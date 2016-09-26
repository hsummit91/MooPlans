package com.mooplans.dao;

import com.mooplans.model.User;
import com.twilio.sdk.TwilioRestClient;
import com.twilio.sdk.TwilioRestException;
import com.twilio.sdk.resource.factory.SmsFactory;
import com.twilio.sdk.resource.instance.Account;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Timer;
import java.util.TimerTask;

public class SMSTwillio extends TimerTask{

	private static ArrayList<User> smsList = new ArrayList<User>();
	private static ArrayList<String> eligiblePhone = new ArrayList<String>();

	public static void sendSMS(User user, int orderId) throws TwilioRestException {

		StringBuilder sb = new StringBuilder();
		sb.append("Hi "+user.getUser_firstname());
		sb.append(", your Moo Plans order(#"+orderId+") was successfully placed. "
				+ "The delivery time is "+user.getDelivery_time());

		String testSMS = sb.toString();

		TwilioRestClient client = new TwilioRestClient("AC2289fa230804acf5141ed429bbeed0f8", "2cacb2471aa293273b8368fc5049fd9d");
		Account account = client.getAccount();
		SmsFactory factory = account.getSmsFactory();

		HashMap<String, String> message = new HashMap<>();

		message.put("To", user.getUser_phone());
		message.put("From", "(518) 302-7545");  // Twilio account number
		message.put("Body", testSMS);
		factory.create(message);

		// Sending details to schedule feedback SMS
		Date orderTime = new Date();
		user.setOrderTime(orderTime);
		smsList.add(user);

		TimerTask task = new SMSTwillio();
		Timer timer = new Timer();
		timer.schedule(task, 1000, 1800000);


	}

	@Override
	public void run() {
		System.out.println("Checking for feedback SMS numbers");
		try {
			SMSTwillio.sendFeedbackSMS();
		} catch (TwilioRestException e) {
			e.printStackTrace();
		}

	}


	public static void sendFeedbackSMS() throws TwilioRestException {

	//	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		Date currentTime = new Date();


		for (User u : smsList) {
			long diff = currentTime.getTime() - u.getOrderTime().getTime();
		//	long diffSeconds = diff / 1000 % 60;
			long diffMinutes = diff / (60 * 1000) % 60;
			long diffHours = diff / (60 * 60 * 1000) % 24;
		//	long diffDays = diff / (24 * 60 * 60 * 1000);

//			System.out.print(diffDays + " days, ");
//			System.out.print(diffHours + " hours, ");
//			System.out.print(diffMinutes + " minutes, ");
//			System.out.print(diffSeconds + " seconds.\n");


			if(diffHours >= 2){
				eligiblePhone.add(u.getUser_phone());
			}
		}

		if(eligiblePhone.size() > 0){

			StringBuilder sb = new StringBuilder();
			sb.append("Hi, it's Moo Plans again. Please take sometime to complete survey. "
					+ "https://www.surveymonkey.com/r/WJY2992");

			String testSMS = sb.toString();

			TwilioRestClient client = new TwilioRestClient("AC2289fa230804acf5141ed429bbeed0f8", "2cacb2471aa293273b8368fc5049fd9d");
			Account account = client.getAccount();
			SmsFactory factory = account.getSmsFactory();

			HashMap<String, String> message = new HashMap<>();

			message.put("To", eligiblePhone.get(0));
			message.put("From", "(518) 302-7545");  // Twillio account number
			message.put("Body", testSMS);
			factory.create(message);
			
			System.out.println("SMS sent to: "+eligiblePhone.get(0));
			eligiblePhone.remove(0);
			if(eligiblePhone.size() > 0)
				smsList.remove(0);
			System.out.println("Current SMS list size: "+smsList.size());
		}
	}
}