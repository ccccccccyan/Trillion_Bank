package vo;

public class ProductVO {
	private int productaccount_idx, saving_money;
    private String user_id, account_productname, account_number, products_period, products_date, endproducts_date;

    private double products_rate, products_tax, products_deal_money;
    

    public String getUser_id() {
		return user_id;
	}
	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}
	public int getProductaccount_idx() {
		return productaccount_idx;
	}
	public void setProductaccount_idx(int productaccount_idx) {
		this.productaccount_idx = productaccount_idx;
	}
	public double getProducts_deal_money() {
		return products_deal_money;
	}
	public void setProducts_deal_money(double products_deal_money) {
		this.products_deal_money = products_deal_money;
	}
	public int getSaving_money() {
		return saving_money;
	}
	public void setSaving_money(int saving_money) {
		this.saving_money = saving_money;
	}
	public String getAccount_productname() {
		return account_productname;
	}
	public void setAccount_productname(String account_productname) {
		this.account_productname = account_productname;
	}
	public String getAccount_number() {
		return account_number;
	}
	public void setAccount_number(String account_number) {
		this.account_number = account_number;
	}
	public String getProducts_period() {
		return products_period;
	}
	public void setProducts_period(String products_period) {
		this.products_period = products_period;
	}
	public String getProducts_date() {
		return products_date;
	}
	public void setProducts_date(String products_date) {
		this.products_date = products_date;
	}
	public String getEndproducts_date() {
		return endproducts_date;
	}
	public void setEndproducts_date(String endproducts_date) {
		this.endproducts_date = endproducts_date;
	}
	public double getProducts_rate() {
		return products_rate;
	}
	public void setProducts_rate(double products_rate) {
		this.products_rate = products_rate;
	}
	public double getProducts_tax() {
		return products_tax;
	}
	public void setProducts_tax(double products_tax) {
		this.products_tax = products_tax;
	}
}
