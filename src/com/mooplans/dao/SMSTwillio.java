package com.mooplans.dao;

import com.mooplans.model.User;
import com.twilio.sdk.TwilioRestClient;
import com.twilio.sdk.TwilioRestException;
import com.twilio.sdk.resource.factory.SmsFactory;
import com.twilio.sdk.resource.instance.Account;

import java.util.HashMap;

public class SMSTwillio {

	public static void sendSMS(User user, int orderId) throws TwilioRestException {

		StringBuilder sb = new StringBuilder();
		sb.append("Hi "+user.getUser_firstname());
		sb.append(", your Moo Plans order(#"+orderId+") was successfully placed. "
				+ "The delivery time is "+user.getDelivery_time());
		//sb.append(". After you receive the food, please take time to complete survey ");
		//sb.append("https://www.surveymonkey.com/r/WJY2992");

		String testSMS = sb.toString();


		TwilioRestClient client = new TwilioRestClient("AC2289fa230804acf5141ed429bbeed0f8", "2cacb2471aa293273b8368fc5049fd9d");
		Account account = client.getAccount();
		SmsFactory factory = account.getSmsFactory();

		HashMap<String, String> message = new HashMap<>();

		message.put("To", user.getUser_phone());
		message.put("From", "(518) 302-7545");  // Twilio account number
		message.put("Body", testSMS);

		factory.create(message);
	}
}