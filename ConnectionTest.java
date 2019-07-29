import java.net.*;
import java.io.*;

public class ConnectionTest {

  public static void main(String[] args) {
    if (args.length < 1) {
      System.out.println("Please provide a URL to attempt to connect to");
      System.exit(1);
    }

    String rawUrl = args[0];
    try {
      URL url = new URL(rawUrl);
      System.out.println(String.format("Attempting connection to URL %s", url));

      try (InputStream input = url.openConnection().getInputStream()) {
        byte[] buffer = new byte[8192];
        long total = 0, read = -1;
        while ((read = input.read(buffer)) > -1) {
          total += read;
        }

        System.out.println(String.format("Successfully read %,d bytes from URL", total));
      }

    } catch (Throwable e) {
      System.err.println(e.getMessage());
      e.printStackTrace(System.err);
    }
  }
}