import java.text.NumberFormat;

import org.w3c.dom.*;
import org.xml.sax.*;

import javax.xml.parsers.*;

import javax.xml.transform.*;
import javax.xml.transform.dom.*;
import javax.xml.transform.stream.*;

import java.io.*;
import java.util.ArrayList;
import java.util.Currency;
import java.util.Scanner;
import java.lang.StringBuilder;

public class Zillow
{
    private static final DocumentBuilderFactory dbFac;
    private static final DocumentBuilder docBuilder;
    static
    {
        try
        {
            dbFac = DocumentBuilderFactory.newInstance();
            docBuilder = dbFac.newDocumentBuilder();
        }
        catch(ParserConfigurationException e)
        {
            throw new RuntimeException(e);
        }
    }
    private static final String DEEP_URL = "http://www.zillow.com/webservice/GetDeepSearchResults.htm";
    private static final String ZESTIMATE_URL = "http://www.zillow.com/webservice/GetZestimate.htm";

    private static final String ZWSID = "X1-ZWz17v79ae0p3f_7aoby";

    private static final NumberFormat nf = NumberFormat.getCurrencyInstance();

    public static String getDeepResults(String address, String cityStateZip) throws SAXException, IOException {
        Document deepDoc = docBuilder.parse(DEEP_URL + "?zws-id=" + ZWSID + "&address=" + address + "&citystatezip=" + cityStateZip);
        Element firstResult = (Element)deepDoc.getElementsByTagName("result").item(0);
        String sqft = "";
        try {
            sqft = firstResult.getElementsByTagName("finishedSqFt").item(0).getTextContent();
        } catch(NullPointerException ex) {
            //System.out.println("info for " + address + " not found!");
        }
        return sqft;
    }
    // Returns Zestimate value for address.
    /*
    public static String getValuation(String address, String cityStateZip) throws SAXException, IOException
    {
        Document deepDoc = docBuilder.parse(DEEP_URL + 
                                        "?zws-id=" + ZWSID + 
                                        "&address=" + address + 
                                        "&citystatezip=" + cityStateZip);
        Element firstResult = (Element)deepDoc.getElementsByTagName("result").item(0);
        String zpid = firstResult.getElementsByTagName("zpid").item(0).getTextContent();
        Document valueDoc = docBuilder.parse(ZESTIMATE_URL + 
                                             "?zws-id=" + ZWSID + 
                                             "&zpid=" + zpid);
        Element zestimate = (Element)valueDoc.getElementsByTagName("zestimate").item(0);
        Element amount = (Element)zestimate.getElementsByTagName("amount").item(0);
        String currency = amount.getAttribute("currency");
        nf.setCurrency(Currency.getInstance(currency));
        //return nf.format(Double.parseDouble(amount.getTextContent()));
        return zpid;
    }
    */
    public static void main(String[] args) throws Throwable
    {
        String path = "/Users/william/Dropbox (Amherst College)/CDS-2019-AlbanyHub/Raw-Data/";
        ArrayList<String> found = new ArrayList<String>();
        ArrayList<String> notFound = new ArrayList<String>();
        int counter = 0;
        int LIMIT = 10;
        try {
            Scanner infile = new Scanner(new FileReader(path + "address_zillow.csv"));
            while(infile.hasNextLine()) {
                if(counter >= LIMIT) {
                    break;
                }
                String fullAddr = infile.nextLine();
                String[] parts = fullAddr.split(",");
                String address = parts[0];
                String cityState = parts[1] + ", " + parts[2];
                String lotSize = getDeepResults(address, cityState);
                counter += 1;
                if(lotSize == "") {
                    notFound.add(fullAddr);
                } else {
                    found.add(fullAddr + "," + lotSize);
                }          
            }
            infile.close();

        } catch(FileNotFoundException ex) {
            System.out.println("File not found");
        }

        PrintWriter outFileFound = new PrintWriter(new File(path + "found_zillow.csv"));
        PrintWriter outFileNotFound = new PrintWriter(new File(path + "notfound_zillow.csv"));
        for(int i = 0; i < found.size(); i++) {
            outFileFound.write(found.get(i) + ",\n");
        }
        for(int i = 0; i < notFound.size(); i++) {
            if(i == notFound.size() - 1) {
                String tmp = notFound.get(i);
                //StringBuilder noComma = new StringBuilder(tmp);
                //int len = noComma.length();
                //tmp = noComma.deleteCharAt(len).toString();
                outFileNotFound.write(tmp);
            } else {
                outFileNotFound.write(notFound.get(i) + ",\n");
            }

        }
        outFileFound.close();
        outFileNotFound.close();


    }
}