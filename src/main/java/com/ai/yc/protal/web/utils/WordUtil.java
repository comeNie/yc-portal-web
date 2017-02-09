package com.ai.yc.protal.web.utils;

import org.apache.poi.POIXMLTextExtractor;
import org.apache.poi.hwpf.extractor.WordExtractor;
import org.apache.poi.poifs.filesystem.DirectoryEntry;
import org.apache.poi.poifs.filesystem.POIFSFileSystem;
import org.apache.poi.xwpf.extractor.XWPFWordExtractor;
import org.apache.poi.xwpf.usermodel.XWPFDocument;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.io.*;

/**
 * Created by mimw on 2017/2/9.
 */
public class WordUtil {
    private static final Logger LOGGER = LoggerFactory.getLogger(WordUtil.class);

    /**
     * 读word文件
     * @param fileName
     */
    public final static String readWord(String fileName){
        if (fileName.endsWith("doc") || fileName.endsWith("DOC")) {
            return readWord2003(fileName);
        }else if (fileName.endsWith("docx") || fileName.endsWith("DOCX")) {
            return readWord2007(fileName);
        }else {
            return "";
        }
    }

    private static String readWord2007(String fileName) {
        POIXMLTextExtractor ex = null;
        XWPFDocument xwpf = null;
        InputStream is = null;
        try {
            is = new FileInputStream(fileName);
            xwpf = new XWPFDocument(is);
            ex = new XWPFWordExtractor(xwpf);
            return ex.getText();
        } catch (FileNotFoundException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        } finally{
            try {
                ex.close();
            } catch (IOException e) {
                e.printStackTrace();
            }
            try {
                xwpf.close();
            } catch (IOException e) {
                e.printStackTrace();
            }
            try {
                is.close();
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
        return null;
    }

    private static String readWord2003(String fileName) {
        WordExtractor wordExtractor = null;
        InputStream fis = null;
        try {
            fis = new FileInputStream(fileName);
            wordExtractor = new WordExtractor(fis);
            String content = wordExtractor.getText();
            return content;
        } catch (FileNotFoundException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        } finally{
            try {
                wordExtractor.close();
            } catch (IOException e) {
                e.printStackTrace();
            }
            try {
                fis.close();
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
        return null;
    }

    /**
     * 写word doc
     * @param destFile
     * @param fileCon
     */

    public final static void writeWord(String destFile, String fileCon) {
        try {
            ByteArrayInputStream bais = new ByteArrayInputStream(fileCon.getBytes());
            POIFSFileSystem fs = new POIFSFileSystem();
            DirectoryEntry directory = fs.getRoot();
            directory.createDocument("WordDocument", bais);
            FileOutputStream ostream = new FileOutputStream(destFile);
            fs.writeFilesystem(ostream);
            bais.close();
            ostream.close();
        } catch (Exception e) {
            e.printStackTrace();
        }

    }
    public static void main(String[] args) {
//       String text = readWord("e:\\WAP端原型-差异-验证结果.docx");
        String text = readWord("e:\\新建 Microsoft Word 97 - 2003 文档.doc");

        LOGGER.info(text);

        writeWord("e:\\1.doc", text);
    }

}
