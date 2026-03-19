package aiwa.condition;

public class ItemSearchCondition {

	private String word;
	private int categoryId;
	private int priceMin;
	private int priceMax;
	private int order;

	public String getWord() {
		return word;
	}

	public void setWord(String word) {
		this.word = word;
	}

	public int getCategoryId() {
		return categoryId;
	}

	public void setCategoryId(int categoryId) {
		this.categoryId = categoryId;
	}

	public int getPriceMin() {
		return priceMin;
	}

	public void setPriceMin(int priceMin) {
		this.priceMin = priceMin;
	}

	public int getPriceMax() {
		return priceMax;
	}

	public void setPriceMax(int priceMax) {
		this.priceMax = priceMax;
	}

	public int getOrder() {
		return order;
	}

	public void setOrder(int order) {
		this.order = order;
	}

}
