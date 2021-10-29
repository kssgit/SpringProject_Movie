package vo;

public class TheaterVO {
	
	private int lt_idx,seat_Total;
	private String m_name,city,district,time,date_s;
	
	
	
	public String getDate_s() {
		return date_s;
	}
	public void setDate_s(String date_s) {
		this.date_s = date_s;
	}
	public int getLt_idx() {
		return lt_idx;
	}
	public void setLt_idx(int lt_idx) {
		this.lt_idx = lt_idx;
	}
	public int getSeat_Total() {
		return seat_Total;
	}
	public void setSeat_Total(int seat_Total) {
		this.seat_Total = seat_Total;
	}
	public String getM_name() {
		return m_name;
	}
	public void setM_name(String m_name) {
		this.m_name = m_name;
	}
	public String getCity() {
		return city;
	}
	public void setCity(String city) {
		this.city = city;
	}
	public String getDistrict() {
		return district;
	}
	public void setDistrict(String district) {
		this.district = district;
	}
	
	public String getTime() {
		return time;
	}
	public void setTime(String time) {
		this.time = time;
	}
	
	
}
