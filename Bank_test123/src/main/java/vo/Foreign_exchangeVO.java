package vo;

public class Foreign_exchangeVO {
	private int fgn_exchange_idx;
    private String user_id;
    private double exchange_money;
    
	public int getFgn_exchange_idx() {
		return fgn_exchange_idx;
	}
	public void setFgn_exchange_idx(int fgn_exchange_idx) {
		this.fgn_exchange_idx = fgn_exchange_idx;
	}
	public String getUser_id() {
		return user_id;
	}
	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}
	public double getExchange_money() {
		return exchange_money;
	}
	public void setExchange_money(double exchange_money) {
		this.exchange_money = exchange_money;
	}

}
