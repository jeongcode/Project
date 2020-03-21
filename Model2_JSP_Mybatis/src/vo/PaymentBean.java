package vo;

public class PaymentBean {
	
	private String nickname , email , tripkind ;
	
	private String oneway_airlinenm , oneway_depairportnm , oneway_arrairportnm , oneway_depdatetime ;
	private int oneway_charge;
	
	private String roundtrip_airlinenm, roundtrip_depairportnm , roundtrip_arrairportnm , roundtrip_arrdatetime ;
	private int roundtrip_charge;
	
	private int totalcharge;
	private String paymentdate;
	private double paymentpoint;
	private int readcheck;
	
	public PaymentBean(){};

	//OneWay Bean
	public PaymentBean(String nickname, String email, String tripkind, String oneway_airlinenm,
			String oneway_depairportnm, String oneway_arrairportnm, String oneway_depdatetime, int oneway_charge,
			int totalcharge, String paymentdate, double paymentpoint , int readcheck) {
		this.nickname = nickname;
		this.email = email;
		this.tripkind = tripkind;
		this.oneway_airlinenm = oneway_airlinenm;
		this.oneway_depairportnm = oneway_depairportnm;
		this.oneway_arrairportnm = oneway_arrairportnm;
		this.oneway_depdatetime = oneway_depdatetime;
		this.oneway_charge = oneway_charge;
		this.totalcharge = totalcharge;
		this.paymentdate = paymentdate;
		this.paymentpoint = paymentpoint;
		this.readcheck = readcheck;
	}
	
	//RoundTrip Bean
	public PaymentBean(String nickname, String email, String tripkind, String oneway_airlinenm,
			String oneway_depairportnm, String oneway_arrairportnm, String oneway_depdatetime, int oneway_charge,
			String roundtrip_airlinenm, String roundtrip_depairportnm, String roundtrip_arrairportnm,
			String roundtrip_arrdatetime, int roundtrip_charge, int totalcharge, String paymentdate, double paymentpoint , int readcheck) {
		this.nickname = nickname;
		this.email = email;
		this.tripkind = tripkind;
		this.oneway_airlinenm = oneway_airlinenm;
		this.oneway_depairportnm = oneway_depairportnm;
		this.oneway_arrairportnm = oneway_arrairportnm;
		this.oneway_depdatetime = oneway_depdatetime;
		this.oneway_charge = oneway_charge;
		this.roundtrip_airlinenm = roundtrip_airlinenm;
		this.roundtrip_depairportnm = roundtrip_depairportnm;
		this.roundtrip_arrairportnm = roundtrip_arrairportnm;
		this.roundtrip_arrdatetime = roundtrip_arrdatetime;
		this.roundtrip_charge = roundtrip_charge;
		this.totalcharge = totalcharge;
		this.paymentdate = paymentdate;
		this.paymentpoint = paymentpoint;
		this.readcheck = readcheck;
	}
	
	public String getNickname() {
		return nickname;
	}
	public void setNickname(String nickname) {
		this.nickname = nickname;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getTripkind() {
		return tripkind;
	}
	public void setTripkind(String tripkind) {
		this.tripkind = tripkind;
	}
	public String getOneway_airlinenm() {
		return oneway_airlinenm;
	}
	public void setOneway_airlinenm(String oneway_airlinenm) {
		this.oneway_airlinenm = oneway_airlinenm;
	}
	public String getOneway_depairportnm() {
		return oneway_depairportnm;
	}
	public void setOneway_depairportnm(String oneway_depairportnm) {
		this.oneway_depairportnm = oneway_depairportnm;
	}
	public String getOneway_arrairportnm() {
		return oneway_arrairportnm;
	}
	public void setOneway_arrairportnm(String oneway_arrairportnm) {
		this.oneway_arrairportnm = oneway_arrairportnm;
	}
	public String getOneway_depdatetime() {
		return oneway_depdatetime;
	}
	public void setOneway_depdatetime(String oneway_depdatetime) {
		this.oneway_depdatetime = oneway_depdatetime;
	}
	public int getOneway_charge() {
		return oneway_charge;
	}
	public void setOneway_charge(int oneway_charge) {
		this.oneway_charge = oneway_charge;
	}
	public String getRoundtrip_airlinenm() {
		return roundtrip_airlinenm;
	}
	public void setRoundtrip_airlinenm(String roundtrip_airlinenm) {
		this.roundtrip_airlinenm = roundtrip_airlinenm;
	}
	public String getRoundtrip_depairportnm() {
		return roundtrip_depairportnm;
	}
	public void setRoundtrip_depairportnm(String roundtrip_depairportnm) {
		this.roundtrip_depairportnm = roundtrip_depairportnm;
	}
	public String getRoundtrip_arrairportnm() {
		return roundtrip_arrairportnm;
	}
	public void setRoundtrip_arrairportnm(String roundtrip_arrairportnm) {
		this.roundtrip_arrairportnm = roundtrip_arrairportnm;
	}
	public String getRoundtrip_arrdatetime() {
		return roundtrip_arrdatetime;
	}
	public void setRoundtrip_arrdatetime(String roundtrip_arrdatetime) {
		this.roundtrip_arrdatetime = roundtrip_arrdatetime;
	}
	public int getRoundtrip_charge() {
		return roundtrip_charge;
	}
	public void setRoundtrip_charge(int roundtrip_charge) {
		this.roundtrip_charge = roundtrip_charge;
	}
	public int getTotalcharge() {
		return totalcharge;
	}
	public void setTotalcharge(int totalcharge) {
		this.totalcharge = totalcharge;
	}
	public String getPaymentdate() {
		return paymentdate;
	}
	public void setPaymentdate(String paymentdate) {
		this.paymentdate = paymentdate;
	}
	public double getPaymentpoint() {
		return paymentpoint;
	}
	public void setPaymentpoint(double paymentpoint) {
		this.paymentpoint = paymentpoint;
	}
	public int getReadcheck() {
		return readcheck;
	}
	public void setReadcheck(int readcheck) {
		this.readcheck = readcheck;
	}
	
	
	
}
