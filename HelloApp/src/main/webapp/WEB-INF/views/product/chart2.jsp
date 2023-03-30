<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<script type="text/javascript"
	src="https://www.gstatic.com/charts/loader.js"></script>
<script type="text/javascript">
      google.charts.load('current', {'packages':['corechart']});
      google.charts.setOnLoadCallback(drawChart);

      function drawChart() {

        var data = google.visualization.arrayToDataTable([
          ['Task', 'Hours per Day'],
          ['Work',     11],
          ['Eat',      2],
          ['Commute',  2],
          ['Watch TV', 2],
          ['Sleep',    7]
        ]);

        var options = {
          title: 'My Daily Activities'
        };

        var chart = new google.visualization.PieChart(document.getElementById('piechart'));

        chart.draw(data, options);
      }
      
    </script>
<script type="text/javascript"
	src="https://www.gstatic.com/charts/loader.js"></script>
<script type="text/javascript">
      google.charts.load('current', {'packages':['corechart']});
      google.charts.setOnLoadCallback(drawChart);
		
      
      
      function drawChart() {
      fetch('chartAjax.do')
      .then(resolve => resolve.json())
      .then(result => {
    	  
    	  let outAry =[];
    	  outAry.push(['dept','Number of people by department']);
    	  
    	  //console.log(result);
      		result.forEach(part=> {
      			console.log(part)
      			let ary = []
      			for (prop in part) {
      				ary[0] = prop;
      				ary[1] = part [prop];
      			}
      			//console.log(ary);
      			outAry.push(ary);
      			
      		    var data = google.visualization.arrayToDataTable(outAry);
      	        var options = {
      	          title: 'Person By Department'
      	        };
      	        var chart = new google.visualization.PieChart(document.getElementById('piechart'));
      	        chart.draw(data, options);
      		})
      })
      .catch(reject => console.error(reject));
      
	//[{'Admin':1},{'Accounting':2}]

      
      }
      
    </script>
</head>
<body>
	<div id="piechart" style="width: 900px; height: 500px;"></div>

</body>
</html>