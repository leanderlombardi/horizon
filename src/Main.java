import java.util.ArrayList;
import java.util.Scanner;

public class Main {
    // Function to check if text is in quotes
    private static boolean isInQuotes(String text) {
        boolean _inQuotes = false;
        for (char c : text.toCharArray()) {
            if (c == '"') {
                _inQuotes = true;
            }
            if (c == '"' && _inQuotes == true) {
                return true;
            }
        }
        return false;
    }
    // I just don't wanna type out "System.out.println()", has no other purposes
    private static void println(String text) { System.out.println(text); }
    public static void main(String[] args) {
        System.out.print("Input: ");
        Scanner sc = new Scanner(System.in);
        String input = sc.next();
        ArrayList<Token> tokens = new ArrayList<Token>();
        boolean _inQuotes = false;
        boolean inQuotes = false;
        for (char c : input.toCharArray()) {
            if (inQuotes) { return; }
            if (c == '+') { tokens.add(new Token(TokenType.PLUS, c)); }
            if (c == '-') { tokens.add(new Token(TokenType.MINUS, c)); }
            if (c == '*') { tokens.add(new Token(TokenType.MUL, c)); }
            if (c == '/') { tokens.add(new Token(TokenType.DIV, c)); }
            if (c == '#') { tokens.add(new Token(TokenType.HASH, c)); }
            if (c == ';') { tokens.add(new Token(TokenType.SEMIC, c)); }
            if (c == '"') { _inQuotes = true; }
            if (c == '"' && _inQuotes == true) { inQuotes = true; }
        }
        int _idx = 0;
        ArrayList<Variable> variables = new ArrayList<Variable>();
        for (String token : input.split(" ")) {
            int idx = _idx;
            if (inQuotes) { return; }
            // Get tokens split by a whitespace
            String[] tk = input.split(" ");
            if (token == "var") {
                // Get type of variable, will later changed to be optional
                if (tk[idx + 2] == "#string") {
                    String[] varValue = input.split("=");
                    int eqIdx = 0;
                    for (String s : varValue) {
                        if (isInQuotes(s)) {
                            eqIdx++;
                            return;
                        } else {
                            variables.add(new Variable(VariableType.STRING, varValue[idx++]));
                            /* for debug */ println(varValue[idx++]);
                        }
                    }
                }
            }
            _idx++;
        }
    }
}
