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

$body$

function toggle_topic(event) {
  //const sub = event.currentTarget.parentNode.querySelector('ul');
	const sub = event.currentTarget.parentNode;
	if (!sub) return;
  sub.classList.toggle('expand-off');
  sub.classList.toggle('expand-on');
	event.stopPropagation();
}

window.addEventListener('DOMContentLoaded', () => {
	document.querySelector('nav').innerHTML += topics;
	// make topics expandable 
	document.querySelectorAll('nav li span+ul').forEach((item)=>{
		const ul = item;
		const li = item.parentNode;
		const span = item.parentNode.querySelector('span'); // we'll use the span as the clickable expandable area
		//const ul = item.querySelector('ul');
		//ul.className = 'expand-off';
		li.className = 'expand expand-off';
		span.addEventListener('click', toggle_topic)
	})
	// highlight active topic
	if (!document.querySelector('.edit-link')) return;
	const link_parts = document.querySelector('.edit-link').href.split('/');
  const topic_id = 'topic-' + link_parts[link_parts.length-1].replace(/\.md$$/, '');
	const active_topic = document.getElementById(topic_id);
	if (active_topic) {
		active_topic.closest('li').className = 'active';
		
		// reveal in the hierarchy
		var current_level = active_topic.closest('ul').className.split('-')[1]|0 +1 ;
		while(current_level >= 0) {
			let to_open = active_topic.closest('.expand-off');
			if (to_open) {
				to_open.classList.toggle('expand-off');
				to_open.classList.toggle('expand-on');
			}
			current_level--;
		}
		
		// center sidebar to active topic
		const bounds = active_topic.offsetParent.getBoundingClientRect();
		active_topic.offsetParent.scrollTop = active_topic.offsetTop - bounds.height/2;
	}
});
