package AprocessControl;
import java.text.NumberFormat;
import java.util.*;

public class Echo {
	public void Scanner() {
		String message;
		Scanner scan = new Scanner(System.in);
		System.out.print("Enter a line of text:  ");
		message = scan.nextLine();
		System.out.println("You entered: \'" + message + "\'");
		scan.close();
	}
	
	public void NumberFor() {
		Double myNumber = 123456.123456789;
		
		String myString = NumberFormat.getInstance().format(myNumber);
		System.out.println("默认格式： " + myString);
		myString = NumberFormat.getCurrencyInstance().format(myNumber);
		System.out.println("通用格式： " + myString);
		myString = NumberFormat.getNumberInstance().format(myNumber);
		System.out.println("通用数值格式： " + myString);
		myString = NumberFormat.getPercentInstance().format(myNumber);
		System.out.println("百分比格式： " + myString);
		NumberFormat format = NumberFormat.getInstance();
		format.setMinimumFractionDigits(3);	//设置数值的小数部分允许的最小位数
		format.setMaximumFractionDigits(5);	//设置数值的小数部分允许的最大位数
		format.setMaximumIntegerDigits(10);	//设置数值的整数部分允许的最大位数
		format.setMinimumIntegerDigits(0);	//设置数值的整数部分允许的最大位数
		System.out.println(format.format(123456.123456));
	}
}
