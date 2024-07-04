package vo;

public class AccountdetailVO {
   private int account_idx, deal_money;
   private String account_number, depo_username, depo_account, bank_date, user_name;
   
   public int getAccount_idx() {
      return account_idx;
   }
   public String getUser_name() {
      return user_name;
   }
   public void setUser_name(String user_name) {
      this.user_name = user_name;
   }
   public void setAccount_idx(int account_idx) {
      this.account_idx = account_idx;
   }
   public int getDeal_money() {
      return deal_money;
   }
   public void setDeal_money(int deal_money) {
      this.deal_money = deal_money;
   }
   
   public String getAccount_number() {
      return account_number;
   }
   public void setAccount_number(String account_number) {
      this.account_number = account_number;
   }
   
   public String getDepo_username() {
      return depo_username;
   }
   public void setDepo_username(String depo_username) {
      this.depo_username = depo_username;
   }
   public String getDepo_account() {
      return depo_account;
   }
   public void setDepo_account(String depo_account) {
      this.depo_account = depo_account;
   }
   public String getBank_date() {
      return bank_date;
   }
   public void setBank_date(String bank_date) {
      this.bank_date = bank_date;
   }
}
