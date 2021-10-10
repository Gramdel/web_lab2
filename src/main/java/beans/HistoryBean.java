package beans;

import java.util.ArrayList;

public class HistoryBean {
    private final ArrayList<String> history;

    public HistoryBean() {
        history = new ArrayList<>();
    }

    public ArrayList<String> getHistory() {
        return history;
    }
}
