import stdlib.themes.bootstrap 
import bootstrap.tabs

type result = {
	int id,
	int arrondissement,
	int polling_place,
	int nb_voted,
	int candidate_id,
	string candidate_name,
	string candidate_first_name,
	int score,
	list(Date.date) log
}

database presidential @mongo {
	result /first[{id}]
}

function increase(result) {
	/presidential/first[id == result.id] <- { score += 800, log <+ Date.now() };
	arr = result.arrondissement;
	#{"a{arr}"} = tab_pan(arr);
}


function table(arr) {
	dbset(result, _) s = /presidential/first[arrondissement == arr; order -score; limit 50];
	it = DbSet.iterator(s);
	Iter.fold(
		function(r, acc) { [table_row(r) | acc]	},
		it, []
	) |> List.rev;
}

function table_row(result) {
	<tr>
		<td>{ result.id }</td>
		<td>{ result.polling_place }</td>
		<td>{ result.candidate_name }</td>
		<td>{ result.score }</td>
		<td>
			<a onclick={ function(_) { increase(result) } }  href="#" class="btn btn-mini">
				Booster
			</a>
		</td>
		<td>{ List.length(result.log) }</td>
	</tr>
}

function tab_pan(arr) {
	<div class="tab-pane" id="a{arr}">
		<table class="table table-striped table-condensed">
			<thead><td>Id</td><td>Bureau de vote</td><td>Candidat</td><td>Score</td><td>Action</td><td>Nb log</td></thead>
			<tbody>{ table(arr) }</tbody>
		</table>
	</div>
}

function tab_nav(arr) {
	<li><a id="t{arr}" href="#a{arr}" data-toggle="tab">{ arr }</a></li>
}

function page() {
	<div class="container" onready={function(_){ Tabs.tab(#t1)} }>
	<h3>Présidentiels 2007 - Tour 1</h3>
	<div class="row-fluid">
		<ul class="nav nav-tabs">
			{ List.init(function(n) { tab_nav(n+1) }, 20) }
		</ul>
		<div class="tab-content">
			{ List.init(function(n) { tab_pan(n+1) }, 20) }
		</div>
	</div>
	</div>
}

Server.start(
	Server.http,
	{
		title : "Elections 2007 - Tour 1",
	 	page : page
	}
)
