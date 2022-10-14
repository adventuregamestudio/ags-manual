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
var whole_word_checkbox;
var was_whole_word;
var highlight_checkbox;
var during_init = true;

window.onload = function() { init(); }

window.addEventListener('DOMContentLoaded', () => {

  const observer = new IntersectionObserver(entries => {
    entries.forEach(entry => {
      const id = entry.target.getAttribute('id');
      if (entry.intersectionRatio > 0) {
        document.querySelector('nav li a[href="#' + id +'"]').parentElement.classList.add('active');
      } else {
        document.querySelector('nav li a[href="#' + id + '"]').parentElement.classList.remove('active');
      }
    });
  });

  // Track all sections that have an `id` applied
  document.querySelectorAll('section[id].level3').forEach((section) => {
    observer.observe(section);
  });
  
});

function update_case_sensitive_checkbox_text()
{
  case_sensitive_checkbox.parentElement.title = case_sensitive_checkbox.checked ? "Match case" : "Ignore case";  
}

function storage(param, value) {
  if(typeof value == 'undefined') {
    var retval = window.localStorage.getItem(param);
    if (retval == 'true' || retval == 'false') return retval == 'true';
    return retval;
  }
  else
    window.localStorage.setItem(param, value);

  return value;
}

function init() {
    ci_keywords = build_ci_keywords();
    search_input = document.getElementById('search_input');
    search_results = document.getElementById('search_results');
    case_sensitive_checkbox = document.getElementById('citoggle');
    case_sensitive_checkbox.checked = storage('case_sensitive') ?? false;
    whole_word_checkbox = document.getElementById('wwtoggle');
    whole_word_checkbox.checked = storage('whole_word') ?? true;
    highlight_checkbox = document.getElementById('hltoggle');
    highlight_checkbox.checked = storage('highlight') ?? true;
    
    previous_search = search_input.value;
    search_check = setInterval(search, SEARCH_CHECK_MS);
    
    update_case_sensitive_checkbox_text();
    do_highlight();
    during_init = false;
}

function citoggle_clicked()
{
  storage('case_sensitive', case_sensitive_checkbox.checked);
  update_case_sensitive_checkbox_text();
  
  search();
}

function wwtoggle_clicked()
{
  storage('whole_word', whole_word_checkbox.checked);
  search();
}

function hltoggle_clicked()
{
  storage('highlight', highlight_checkbox.checked);
  do_highlight();
}

function search() {
    var query = search_input.value.replace(/[\])}[{(]/g, '');
    var is_case_sensitive = case_sensitive_checkbox.checked;
    var is_whole_word = whole_word_checkbox.checked;

    if (query !== previous_query || was_case_sensitive != is_case_sensitive || was_whole_word != is_whole_word) {
        previous_query = query;
        update_results(query.split(/\s+/), is_case_sensitive, is_whole_word)
    }
    
    was_case_sensitive = is_case_sensitive;
    was_whole_word = is_whole_word;
}

function search_partial_key(haystack, searchValue) {
    if (typeof searchValue != 'undefined' && searchValue.length < 3) return [];
    var matches = [];

    for (var key in haystack) {
        if (key.startsWith(searchValue)) {
          matches.push(key);
        }
    }
    return matches;
};

function update_results(words, is_case_sensitive, is_whole_world) {
    //remove exiting entries
    while (search_results.firstChild) {
        search_results.removeChild(search_results.firstChild);
    }

    var track = { "total": Object.create(null), "which": Object.create(null) }

    var keywords =  is_case_sensitive ? meta.keywords : ci_keywords;

    words.forEach(word => {
        if (!is_case_sensitive) word = word.toLowerCase();

        // naive partial matching
        if (!is_whole_world) {
          let matches = search_partial_key(keywords, word);
          matches.forEach(word2 => {
            if (word2 in keywords) {
                var max = Object.keys(keywords[word2]).length;

                for (var i = 0; i < max; i ++) {
                Object.keys(keywords[word2][i]).forEach(docname => {
                        // add counts for multiple hits
                        if (docname in track.total) {
                            track.total[docname] += keywords[word2][i][docname];
                        } else {
                            track.total[docname] = keywords[word2][i][docname];
                        }

                        // track which search words were found
                        if (!(docname in track.which)) {
                            track.which[docname] = {}
                        }

                        track.which[docname][word2] = keywords[word2][i][docname]
                        
                   })
                }
            }
          });
          return;
        } 


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
        var title = meta.titles[docname];
        var labels = create_labels(track.which[docname]);

        var a = document.createElement('a');
        a.title = title;
        a.href = docname + '.html?highlight=' + encodeURIComponent(found_by.join(' ')) + 
                 '&case_sensitive=' + (case_sensitive_checkbox.checked ? '1' : '0')
        a.appendChild(document.createTextNode(title));

        var li = document.createElement('li');
        li.appendChild(a);
        li.appendChild(labels);
        li.className = 'search-match';
        search_results.appendChild(li);
    });
}

function create_labels(labels, max) {
  var span = document.createElement('span');
  span.className = "labels";
  for (var label in labels) {
    var spanlabel = document.createElement('span');
    spanlabel.className = "label";
    spanlabel.innerText = label;
    var spancount = document.createElement('span');
    spancount.className = "label-count";
    spancount.innerText = labels[label];
    spanlabel.appendChild(spancount);
    span.appendChild(spanlabel);
  }
  return span;
  
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
      "caseSensitive": case_sensitive,
      "accuracy": {
        "value": whole_word_checkbox.checked ? 'exactly' : 'partially',
        "limiters": [",", "."]
      }
    }

    if (highlight_checkbox.checked) 
      instance.mark(highlight, options);
    else
      instance.unmark();

    // move to first occurrence of highlighted word, if any, and only after page load
    // there are no better alternatives at the moment, since inner page titles are not available as a match entry
    if (during_init) {
      // delayed call to wait for markjs
      setTimeout(function(){
        var mark = document.querySelector("main mark")
        if (mark) window.scrollTo(0, mark.offsetTop);
      },0);
    }
}

$body$
