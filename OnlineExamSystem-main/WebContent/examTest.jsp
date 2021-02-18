<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="com.connection.*"%>
<%@ page import="java.sql.*"%>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">

<!-- Mirrored from www.binarytheme.com/BTlivedemos/2014/08/29/horizontal-admin/blank.html by HTTrack Website Copier/3.x [XR&CO'2014], Sun, 14 Jul 2019 14:48:34 GMT -->
<head>

<meta charset="utf-8" />
<meta name="viewport"
	content="width=device-width, initial-scale=1, maximum-scale=1" />
<meta name="description" content="" />
<meta name="author" content="" />
<!--[if IE]>
        <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
        <![endif]-->
<title>Online Exam System</title>
<!-- BOOTSTRAP CORE STYLE  -->
<link href="assets/css/bootstrap.css" rel="stylesheet" />
<!-- FONT AWESOME STYLE  -->
<link href="assets/css/font-awesome.css" rel="stylesheet" />
<!-- CUSTOM STYLE  -->
<link href="assets/css/style.css" rel="stylesheet" />
<!-- GOOGLE FONT -->
<link href='http://fonts.googleapis.com/css?family=Open+Sans'
	rel='stylesheet' type='text/css' />
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
<script language="javascript">
	var tim;
	var min = 10;
	var sec = 0;
	function customSubmit(someValue) {
		document.getElementById("questionForm").submit();
	}
	function examTimer() {
		if (parseInt(sec) > 0) {
			document.getElementById("showtime").innerHTML = "Time Remaining : "
					+ " " + +min + " Minutes, " + sec + " Seconds";
			sec = parseInt(sec) - 1;
			tim = setTimeout("examTimer()", 1000);
		} else {
			if (parseInt(min) == 0 && parseInt(sec) == 0) {
				document.getElementById("showtime").innerHTML = "Time Remaining : "
						+ " " + +min + " Minutes, " + sec + " Seconds";
				window.location.href = "timeValidity.jsp";
				document.getElementById("questionForm").submit();
			}
			if (parseInt(sec) == 0) {
				document.getElementById("showtime").innerHTML = "Time Remaining : "
						+ " " + +min + " Minutes, " + sec + " Seconds";
				min = parseInt(min) - 1;
				sec = 59;
				tim = setTimeout("examTimer()", 1000);
			}
		}
	}
</script>
<script>
	function myFunction() {
		var selectTopic = document.getElementById("mySelect").value;
		document.location.href = "examTest.jsp?selectTopic=" + selectTopic;
		
	}
</script>

</head>
<body onload="examTimer()">
	<%
		if (session.getAttribute("uname") != null && session.getAttribute("uname") != "") {
	%>
	<div class="navbar navbar-inverse set-radius-zero">
		<div class="container">
			<div class="navbar-header">
				<button type="button" class="navbar-toggle" data-toggle="collapse"
					data-target=".navbar-collapse">
					<span class="icon-bar"></span> <span class="icon-bar"></span> <span
						class="icon-bar"></span>
				</button>
				<a class="navbar-brand" href="index.jsp"> <img
					src="images/logo.png" style="width: 200px; height: 70px;" />
				</a>
			</div>

			<div class="right-div">
				<a href="logout.jsp" class="btn btn-info pull-right">LOG ME OUT</a>
			</div>
		</div>
	</div>
	<div id="showtime" style="position: absolute; left: 800px; top: 20px"></div>
	<jsp:include page="studentSideHeader.jsp"></jsp:include>
	<div class="content-wrapper">
		<div class="container">
			<form action="Examination" method="post" name="questionForm"
							id="questionForm">
			<div class="row pad-botm">
				<div class="col-md-12">
					<h4 class="header-line">Subject Test</h4>
				</div>
				
				<div class="form-group">
	
					<label>Select Topic.:</label> <select name="selectTopic"
						 id="mySelect" onchange="myFunction()" class="form-control">
						<option>Select Exam Subject Topic</option>
						<%
							ResultSet selectExamTopic = DatabaseConnection.getResultFromSqlQuery("select distinct subjectTopic from questions");
							while (selectExamTopic.next()) {
						%>
							<option> <%=selectExamTopic.getString("subjectTopic") %> </option>
						<%
							}
						%>
					</select>
				</div>
			</div>
			<div class="row">
				<div class="col-md-12">
					<div class="alert alert-default">
						
							<%
							int questionId=0;
							int id=0;
							String selectTopic = request.getParameter("selectTopic");
							session.setAttribute("selectTopic", selectTopic);
							System.out.println("selectTopic  "+selectTopic);
							ResultSet rs = DatabaseConnection.getResultFromSqlQuery("select * from questions where subjectTopic='"+selectTopic+"'");
							while (rs.next()) {
								 id=rs.getInt(1);
								 questionId++;
							%>
							<div class="form-group">
								<label><%=questionId%>. <%=rs.getString(2)%></label>
							</div>

							<div class="radio">
								<input type="radio" name="<%=id%>" value="<%=rs.getString(3)%>"> <%=rs.getString(3)%> </div>

							<div class="radio">
								<input type="radio" name="<%=id%>" value="<%=rs.getString(4)%>"><%=rs.getString(4)%></div>

							<div class="radio">
								<input type="radio" name="<%=id%>" value="<%=rs.getString(5)%>"><%=rs.getString(5)%></div>

							<div class="radio">
								<input type="radio" name="<%=id%>" value="<%=rs.getString(6)%>"><%=rs.getString(6)%></div>

							<%
								}
							%>
							<input type="submit" value="Finish Exam" class="btn btn-primary"
								onclick="customSubmit()">&nbsp; <input type="reset"
								value="Reset" class="btn btn-danger">
						
					</div>
				</div>
			</div>
			</form>
		</div>
	</div>
	<section class="footer-section">
		<div class="container">
			<div class="row">
				<div class="col-md-12">&copy; Professional Practice Project</div>

			</div>
		</div>
	</section>
	<!-- FOOTER SECTION END-->
	<!-- JAVASCRIPT FILES PLACED AT THE BOTTOM TO REDUCE THE LOADING TIME  -->
	<!-- CORE JQUERY  -->
	<script src="assets/js/jquery-1.10.2.js"></script>
	<!-- BOOTSTRAP SCRIPTS  -->
	<script src="assets/js/bootstrap.js"></script>
	<!-- CUSTOM SCRIPTS  -->
	<script src="assets/js/custom.js"></script>
	<script>
		(function(i, s, o, g, r, a, m) {
			i['GoogleAnalyticsObject'] = r;
			i[r] = i[r] || function() {
				(i[r].q = i[r].q || []).push(arguments)
			}, i[r].l = 1 * new Date();
			a = s.createElement(o), m = s.getElementsByTagName(o)[0];
			a.async = 1;
			a.src = g;
			m.parentNode.insertBefore(a, m)
		})
				(
						window,
						document,
						'script',
						'../../../../../../www.google-analytics.com/analytics.js',
						'ga');

		ga('create', 'UA-58127580-1', 'auto');
		ga('send', 'pageview');
	</script>
	<%
		} else {
	response.sendRedirect("index.jsp");
	}
	%>
</body>
</html>
