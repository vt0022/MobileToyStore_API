package com.mobileprogramming.mobiletoystore.utility;

import java.security.MessageDigest;

public class SHA512Hash {
	public static String encryptThis(String input) {
		StringBuilder sb = new StringBuilder();
		try {
			MessageDigest digest = MessageDigest.getInstance("SHA-512");
			digest.update(input.getBytes());
			byte[] byteData = digest.digest();
			for (byte x : byteData) {
				String str = Integer.toHexString(Byte.toUnsignedInt(x));
				if (str.length() < 2) {
					sb.append('0');
				}
				sb.append(str);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return sb.toString();
	}
}
