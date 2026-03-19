package aiwa.util;

import java.text.SimpleDateFormat;

public class StringUtil {
	public static String toDate(String str) {
		
		SimpleDateFormat from = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		SimpleDateFormat to = new SimpleDateFormat("yyyy年MM月dd日 HH:mm:ss");
		
		try {
			
		
		return to.format(from.parse(str));
		
		}catch(Exception e) {
			e.printStackTrace();
		}
		return "";
	}

	public static String toBr(String str) {
		return str.replace("\r\n", "<br>");
	}

	public static String toMoney(int price) {
		return String.format("%,d", price) + "円";
	}

	public static String toStars(double rating) {

		String full = "<i class='bi bi-star-fill me-1'></i>";
		String half = "<i class='bi bi-star-half'></i>";

		String stars = "<span class='text-warning'>";

		for (int i = 0; i < (int) rating; i++) {
			stars += full;
		}

		if (rating - (int) rating > 0) {
			stars += half;
		}

		stars += "</span>";

		return stars;
	}
}
