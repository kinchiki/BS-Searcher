javascript:(function(a){a.forEach(v=>console.log(v.href.replace(/[ \r\n]+$/gim,"")+","+v.text.replace(/[ \r\n]+$/gim,"")));})(document.querySelectorAll('li.search-cassette>div>div>div>a'));

javascript:(
function(d,c){
c=d.childNodes[0].textContent;
console.log(c);
})(document.querySelector('table.company-information:nth-child(4)>tbody:nth-child(1)>tr:nth-child(1)>td:nth-child(2)'),null);