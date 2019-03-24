var SEARCH_CHECK_MS = 600;
var search_input;
var search_results;
var search_check;
var previous_query;

window.onload = function() { init(); }

function init() {
    search_input = document.getElementById('search_input');
    search_results = document.getElementById('search_results');
    previous_search = search_input.value;
    search_check = setInterval(search, SEARCH_CHECK_MS);
}

function search() {
    var query = search_input.value;

    if (query !== previous_query) {
        previous_query = query;
        update_results(query.split(/\s+/))
    }
}

function update_results(words) {
    //remove exiting entries
    while (search_results.firstChild) {
        search_results.removeChild(search_results.firstChild);
    }

    var track = { "total": Object.create(null), "which": Object.create(null) }

    words.forEach(word => {
        if (word in meta.keywords) {
            var max = Object.keys(meta.keywords[word]).length;

            for (var i = 0; i < max; i ++) {
            Object.keys(meta.keywords[word][i]).forEach(docname => {
                    // add counts for multiple hits
                    if (docname in track.total) {
                        track.total[docname] += meta.keywords[word][i][docname];
                    } else {
                        track.total[docname] = meta.keywords[word][i][docname];
                    }

                    // track which search words were found
                    if (!(docname in track.which)) {
                        track.which[docname] = {}
                    }

                    track.which[docname][word] = meta.keywords[word][i][docname]
               })
            }
        }
    });

    if (Object.keys(track.total).length === 0 && words[0] !== '') {
        var li = document.createElement('li');
        li.innerHTML = 'No match';
        li.className = 'search-nomatch';
        search_results.appendChild(li);
        return;
    }

    Object.keys(track.total).sort(function(a, b) {return track.total[b] - track.total[a]}).forEach(docname => {
        var found_by = Object.keys(track.which[docname])
        var title = meta.titles[docname] + ' ' + JSON.stringify(track.which[docname])

        var a = document.createElement('a');
        a.appendChild(document.createTextNode(title));
        a.title = title;
        a.href = docname + '.html?highlight=' + encodeURIComponent(found_by.join(' '))

        var li = document.createElement('li');
        li.appendChild(a);
        li.className = 'search-match';
        search_results.appendChild(li);
    });
}

$body$
