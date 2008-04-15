var vals = new Array();
var rates = new Array();
var fields = new Array();
var total = 0;
var average = 0;
function addToDebug(val, val2)
{
	vals.push(val);
	fields.push(val2);
}
function calc()
{
	var l_rates = new Array();
	i = 0;
	for (id in vals)
	{
		if (typeof(vals[id]) != 'function')
		{
			var e = document.getElementById(vals[id]);	
			var str = vals[id].replace(/debug/, "criteria_")
			var f = document.getElementById(str);
			var h = parseInt(e.innerHTML);
			f.value = h;
			if (!isNaN(h))
			{
				l_rates.push(h);
				i += h;
			}
			rates = l_rates;
			total = i;
			updateAv();
		}
	}
}

function updateAv()
{
	total = rates.sum();
	average = Math.round(total/rates.length * 10);
	a = document.getElementById('av-percent');
	if (!isNaN(average))
	{
		a.innerHTML = average + "%";
	}
	else
	{
		a.innerHTML = "N/A";
	}
}

Array.prototype.sum = function(){
        for(var i=0,sum=0;i<this.length;sum+=this[i++]);
        return sum;
}