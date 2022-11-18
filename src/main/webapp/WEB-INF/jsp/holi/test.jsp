<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="${pageContext.request.contextPath}/css/fullcalendarmain.css" rel="stylesheet">
<script src="${pageContext.request.contextPath}/js/fullcalendarmain.js"></script>
<script src="${pageContext.request.contextPath}/js/jquery.min.js"></script>
<script>	
var calendar
	document.addEventListener('DOMContentLoaded', function() {
		$(function () {
			var request  = $.ajax({
				type: "GET",
				url: "${pageContext.request.contextPath}/holi/calendar.do",
				dataType : "json"				
			});
			
			request.done(function (data) {
				console.log(data);
				
				var calendarEl = document.getElementById('calendar');
				
				calendar = new FullCalendar.Calendar(calendarEl, {
					headerToolbar : {
						left: 'prev,next today',
                        center: 'title',
                        right: 'dayGridMonth,timeGridWeek,timeGridDay,listWeek'
					},					
					locale : 'ko',
					height : '700px', // calendar 높이 설정					
					expandRows : true,
					events: data
                });
				calendar.render();
				
			});
			request.fail(function( jqXHR, textStatus ) {
            alert( "Request failed: " + textStatus );
        });
    });

});
	
	
</script>

</head>
<body>	
	<div id='calendar'></div>	
</body>
</html>