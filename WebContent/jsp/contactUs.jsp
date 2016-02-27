<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Contact</title>
<link rel="stylesheet" href="../css/reset.css">
</head>
<body>
	<form action="../Feedback" method="post">
		<table id="example" class="display" cellspacing="0" width="80%">
			<thead align="left">
				<tr>
					<th>Contact Form</th>
				</tr>
			</thead>
			<tfoot align="left">
				<tr>
					<th>Footer Link</th>
				</tr>
			</tfoot>
			<tbody align="left">
						<tr>
							<td>Name: <span style="color: #D70000">*</span><br> <input
								type="text" name="name" required placeholder="Name" /></td>
						</tr>
						<tr>
							<td>E-mail Address: <span style="color: #D70000">*</span><br>
								<input type="text" name="email" required placeholder="Email Id" /></td>
						</tr>
						<tr>
							<td>Phone Number:<br> <input type="text" name="number" /></td>
						</tr>
						<tr>
							<td>Subject: <span style="color: #D70000">*</span><br>
								<input type="text" name="subject" required placeholder="Subject" /></td>
						</tr>
						<tr>
							<td>Message: <span style="color: #D70000">*</span><br>
								<textarea name="message" cols="42" rows="9" required
									placeholder="Message body"></textarea></td>
						</tr>
						<tr>
							<td><input type="submit" value="Send Message"
								style="font-weight: bold"></td>
						</tr>
					</tbody>
		</table>
	</form>
	<script src="./js/jquery.min.js"></script>
	<script src="./js/dataTables.js"></script>
	<script src="./js/app.js"></script>

</body>
</html>