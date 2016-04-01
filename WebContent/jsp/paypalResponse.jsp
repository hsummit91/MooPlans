<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	<form action="https://www.paypal.com/cgi-bin/webscr" method="post"
		target="_top">
		<input type="hidden" name="cmd" value="_s-xclick"> <input
			type="hidden" name="hosted_button_id" value="QM2U39HHQ6LLG">
		<table>
			<tr>
				<td><input type="hidden" name="on0" value="Meal Plans">Meal
					Plans</td>
			</tr>
			<tr>
				<td><select name="os0">
						<option value="Mini Plan">Mini Plan</option>
						<option value="Medium Plan">Medium Plan</option>
						<option value="Large Plan">Large Plan</option>
						<option value="Premium Plan">Premium Plan</option>
				</select></td>
			</tr>
		</table>
		<input type="hidden" name="currency_code" value="USD"> <input
			type="image"
			src="https://www.paypalobjects.com/en_US/i/btn/btn_buynowCC_LG.gif"
			border="0" name="submit"
			alt="PayPal - The safer, easier way to pay online!"> <img
			alt="" border="0"
			src="https://www.paypalobjects.com/en_US/i/scr/pixel.gif" width="1"
			height="1">
	</form>

</body>
</html>