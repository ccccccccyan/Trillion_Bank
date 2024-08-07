package vo;

public class ProductVO {
	private int productaccount_idx, saving_money, products_deal_money, auto, end_saving_money;
    private String user_id, account_productname, account_number, products_period, products_date, endproducts_date, deadline, product_color, product_card_img;

    private double products_rate, products_tax;
    
    public String getProduct_color() {
    	if(account_productname.equals("정기예금")) {
    		return "#51d3ed";
    	}else if(account_productname.equals("청년정기예금")) {
    		return "#40a4e3";
    		
    	}else if(account_productname.equals("정기적금")) {
    		return "#f5a364";
    		
    	}else{
    		return "#F6C2CF";
    	}
    }
    public String getProduct_card_img() {
    	if(account_productname.equals("정기예금")) {
    		return "환호";
    	}else if(account_productname.equals("청년정기예금")) {
    		return "사람";
    		
    	}else if(account_productname.equals("정기적금")) {
    		return "새";
    		
    	}else{
    		return "개";
    	}
    }
    
    public int getEnd_saving_money() {
		return end_saving_money;
	}
	public void setEnd_saving_money(int end_saving_money) {
		this.end_saving_money = end_saving_money;
	}
	public String getDeadline() {
		return deadline;
	}
	public void setDeadline(String deadline) {
		this.deadline = deadline;
	}
	public int getAuto() {
		return auto;
	}
	public void setAuto(int auto) {
		this.auto = auto;
	}
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
	public int getProducts_deal_money() {
		return products_deal_money;
	}
	public void setProducts_deal_money(int products_deal_money) {
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
