package com.ai.yc.protal.web.utils;

import com.ai.yc.protal.web.model.DocParagraphTrans;
import org.apache.commons.lang3.StringUtils;
import org.apache.poi.POIXMLTextExtractor;
import org.apache.poi.hwpf.HWPFDocument;
import org.apache.poi.hwpf.extractor.WordExtractor;
import org.apache.poi.hwpf.usermodel.Paragraph;
import org.apache.poi.hwpf.usermodel.Range;
import org.apache.poi.poifs.filesystem.DirectoryEntry;
import org.apache.poi.poifs.filesystem.DocumentEntry;
import org.apache.poi.poifs.filesystem.POIFSFileSystem;
import org.apache.poi.xwpf.extractor.XWPFWordExtractor;
import org.apache.poi.xwpf.usermodel.XWPFDocument;
import org.apache.poi.xwpf.usermodel.XWPFParagraph;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.io.*;
import java.util.Iterator;
import java.util.LinkedList;
import java.util.List;

/**
 * Created by mimw on 2017/2/9.
 */
public class WordUtil {
    private static final Logger LOGGER = LoggerFactory.getLogger(WordUtil.class);

    /**
     * 读word文件
     * @param fileName
     */
    public final static String readWord(String fileName, InputStream is){
        if (fileName.endsWith("doc") || fileName.endsWith("DOC")) {
            return readWord2003(fileName, is);
        }else if (fileName.endsWith("docx") || fileName.endsWith("DOCX")) {
            return readWord2007(fileName, is);
        }else {
            try {
                is.close();
            } catch (IOException e) {
                e.printStackTrace();
            }
            return "";
        }
    }

    // 按段获取文本(仅对doc文件有效)
    public static List<DocParagraphTrans> getTextByParagraph(String fileName,InputStream is) {
        List<DocParagraphTrans> paragraphTransList = new LinkedList<>();
        try {
            //doc，2003
            if (StringUtils.isNotBlank(fileName) && fileName.toLowerCase().endsWith("doc")) {
                WordExtractor wordExtractor = new WordExtractor(is);
                // 获取段文本
                String[] strArray = wordExtractor.getParagraphText();
                for (int i = 0; i < strArray.length; i++) {
                    if (LOGGER.isDebugEnabled()) {
                        LOGGER.debug("第{}段：{}", (i + 1), strArray[i]);
                    }
                    //忽略空行
                    if(StringUtils.isBlank(strArray[i])) {
                        continue;
                    }
                    DocParagraphTrans paragraphTrans = new DocParagraphTrans();
                    paragraphTrans.setSourceText(strArray[i]);
                    paragraphTransList.add(paragraphTrans);
                }

            } else if (StringUtils.isNotBlank(fileName) && fileName.toLowerCase().endsWith("docx")) {
                // 这个构造函数从InputStream中加载Word文档
                XWPFDocument doc = new XWPFDocument(is);
                Iterator<XWPFParagraph> iterator = doc.getParagraphsIterator();
                int i = 0;
                while (iterator.hasNext()){
                    i++;
                    XWPFParagraph paragraph = iterator.next();
                    if (LOGGER.isDebugEnabled()) {
                        LOGGER.debug("第{}段：{}", i, paragraph.getParagraphText());
                    }
                    //忽略空行
                    if(StringUtils.isBlank(paragraph.getParagraphText())) {
                        continue;
                    }
                    DocParagraphTrans paragraphTrans = new DocParagraphTrans();
                    paragraphTrans.setSourceText(paragraph.getParagraphText());
                    paragraphTransList.add(paragraphTrans);
                }
            }
            LOGGER.debug("一共{}段", paragraphTransList.size());
        } catch (IOException e) {
            LOGGER.error("分段读取失败。",e);
        }
        return paragraphTransList;
    }

    private static String readWord2007(String fileName, InputStream is) {
        POIXMLTextExtractor ex = null;
        XWPFDocument xwpf = null;
        try {
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

    private static String readWord2003(String fileName,   InputStream is) {
        WordExtractor wordExtractor = null;
        try {
            wordExtractor = new WordExtractor(is);
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
                is.close();
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
//            fileCon =  new String(fileCon.getBytes("utf-8"), "ISO-8859-1");;
            ByteArrayInputStream bs = new ByteArrayInputStream(fileCon.getBytes("GBK"));

            POIFSFileSystem fs = new POIFSFileSystem();
            DirectoryEntry directory = fs.getRoot();

            DocumentEntry de = directory.createDocument("WordDocument", bs);

            FileOutputStream ost = new FileOutputStream(destFile);
            fs.writeFilesystem(ost);

            bs.close();
            ost.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public static void main(String[] args) throws IOException {
        FileInputStream fis = null;
        try {
            fis = new FileInputStream(new File(""));
//            String text = readWord("e:\\WAP端原型-差异-验证结果.docx");
//        String text = readWord("e:\\新建 Microsoft Word 97 - 2003 文档.doc");
//
//            LOGGER.info(text);
//        writeWord("e:\\打发打发打发的.doc", text);
        } catch (FileNotFoundException e) {
            e.printStackTrace();
        } finally {
            if (fis!=null){
                fis.close();
            }
        }
    }

}
