<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<head>
  <meta charset='utf-8' />
  <script src='full/dist/index.global.js'></script>
  <script>

    document.addEventListener('DOMContentLoaded', async function () {
      //FETCH API를 사용
      
      let events = [];

      let promise1 = await fetch('calendar.do');
      let promise2 = await promise1.json();
          promise2.forEach(function (calendar) {
            console.log(calendar);
            let obj = {title: calendar.title, start: calendar.startDate, end: calendar.endDate}
            events.push(obj)

          })


      var calendarEl = document.getElementById('calendar');

      var calendar = new FullCalendar.Calendar(calendarEl, {
        headerToolbar: {
          left: 'prev,next today',
          center: 'title',
          right: 'dayGridMonth,timeGridWeek,timeGridDay'
        },
        initialDate: '2023-01-12',
        navLinks: true, // can click day/week names to navigate views
        selectable: true,
        selectMirror: true,
        select: function (arg) {
          var title = prompt('Event Title:');
          if (title) {
        	  	console.log(arg)
        	  	fetch('calendarAdd.do?title='+title+'&start='+arg.startStr+'&end='+arg.endStr)
        	  	.then(resolve => resolve.json())
        	  	.then(result => {
        	  		result=arg;
        	  		
        	  		let abc ={"title" :title, "start":arg.startStr, "end":arg.endStr }
        	  		
        	  	})
        	  	.catch(reject=>console.error(reject));
        	  	
        	  	//화면에 이벤트를 등록.
            calendar.addEvent({
              title: title,
              start: arg.start,
              end: arg.end,
              allDay: arg.allDay
            })
          }
          calendar.unselect()
        },
        
        
        
        /////
        eventClick: function (arg) {
          if (confirm('Are you sure you want to delete this event?')) {
            fetch('calendarRemove.do?title=' + title)
        	  .then(resolve =>resolve.json())
        	  .then(result =>{
        		   
        		        		  
        		  
        		  
        	  })
        	  .catch(reject => console.error(reject));
        	
        		  arg.event.remove()	
        		  
        	  
        	  }
        },
        editable: true,
        dayMaxEvents: true, // allow "more" link when too many events
        events: events
      });

      calendar.render();
    });
  </script>
  <style>
    body {
      margin: 40px 10px;
      padding: 0;
      font-family: Arial, Helvetica Neue, Helvetica, sans-serif;
      font-size: 14px;
    }

    #calendar {
      max-width: 1100px;
      margin: 0 auto;
    }
  </style>
</head>

<body>

  <div id='calendar'></div>

</body>

</html>