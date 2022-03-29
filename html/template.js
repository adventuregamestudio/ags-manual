/*
@licstart  The following is the entire license notice for the JavaScript code in this page.

MIT License

Copyright (c) 2020 various contributors

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.

@licend  The above is the entire license notice for the JavaScript code in this page.
*/

var SEARCH_CHECK_MS = 600;
var search_input;
var search_results;
var search_check;
var previous_query;
var ci_keywords;
var case_sensitive_checkbox;
var was_case_sensitive;

window.onload = function() { init(); }

function update_case_sensitive_checkbox_text()
{
  case_sensitive_checkbox.title = case_sensitive_checkbox.checked ? "Match case" : "Ignore case";  
}

function init() {
    ci_keywords = build_ci_keywords();
    search_input = document.getElementById('search_input');
    search_results = document.getElementById('search_results');
    case_sensitive_checkbox = document.getElementById('citoggle');
    previous_search = search_input.value;
    search_check = setInterval(search, SEARCH_CHECK_MS);
    
    update_case_sensitive_checkbox_text();
    do_highlight();
}

function citoggle_clicked()
{
  update_case_sensitive_checkbox_text();
  
  search();
}

function search() {
    var query = search_input.value;
    var is_case_sensitive = case_sensitive_checkbox.checked;

    if (query !== previous_query || was_case_sensitive != is_case_sensitive) {
        previous_query = query;
        update_results(query.split(/\s+/), is_case_sensitive)
    }
    
    was_case_sensitive = is_case_sensitive;
}

function update_results(words, is_case_sensitive) {
    //remove exiting entries
    while (search_results.firstChild) {
        search_results.removeChild(search_results.firstChild);
    }

    var track = { "total": Object.create(null), "which": Object.create(null) }

    var keywords =  is_case_sensitive ? meta.keywords : ci_keywords;

    words.forEach(word => {
        if (!is_case_sensitive) word = word.toLowerCase();
        if (word in keywords) {
            var max = Object.keys(keywords[word]).length;

            for (var i = 0; i < max; i ++) {
            Object.keys(keywords[word][i]).forEach(docname => {
                    // add counts for multiple hits
                    if (docname in track.total) {
                        track.total[docname] += keywords[word][i][docname];
                    } else {
                        track.total[docname] = keywords[word][i][docname];
                    }

                    // track which search words were found
                    if (!(docname in track.which)) {
                        track.which[docname] = {}
                    }

                    track.which[docname][word] = keywords[word][i][docname]
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
        a.href = docname + '.html?highlight=' + encodeURIComponent(found_by.join(' ')) + 
                 '&case_sensitive=' + (case_sensitive_checkbox.checked ? '1' : '0')

        var li = document.createElement('li');
        li.appendChild(a);
        li.className = 'search-match';
        search_results.appendChild(li);
    });
}

function build_ci_keywords() {
    var output = {};

    // build up the lookup table
    Object.keys(meta.keywords).forEach(word => { 
        var max = Object.keys(meta.keywords[word]).length;
        var ci_word = word.toLowerCase();
        if (!output[ci_word]) output[ci_word] = {};
        var ci_children_count = Object.keys(output[ci_word]).length;
        
        for (var i = 0; i < max; i ++) {
            output[ci_word][ci_children_count + i] = meta.keywords[word][i];
        }
    });
    
    return output;
}

function do_highlight() {
    var urlParams = new URLSearchParams(window.location.search);
    var highlight = urlParams.get('highlight');
    var case_sensitive = urlParams.get('case_sensitive') == '1';
    
    if (!highlight) return;
    
    var instance = new Mark(document.querySelector("main"));
    
    var options = {
      "caseSensitive": case_sensitive
    }
    
    instance.mark(highlight, options);
}

$body$
