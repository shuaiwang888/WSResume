package com.ws.wr.util;

import com.ws.wr.bean.UploadParams;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.commons.io.FileUtils;
import org.apache.commons.io.FilenameUtils;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.io.InputStream;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

public class Uploads {
    private static final String BASE_DIR = "upload";
    private static final String IMG_DIR = "image";

    /**
     * 图片上传
     * @param item 文件参数
     * @param request 请求
     * @param oldImage 以前的图片路径（为了在编辑时没有修改图片操作时）
     * @return 存储到数据库的图片路径
     * @throws Exception
     */
    public static String uploadImage(FileItem item, HttpServletRequest request, String oldImage) throws Exception {
        //在开始没有设置图片后的编辑操作时，作出的逻辑判断，以防止数据库存空串
        if (oldImage != null && oldImage.length() == 0) {
            oldImage = null; // 如果图片是空字符串，就设置为null
        }

        if (item == null) return oldImage;
        InputStream is = item.getInputStream();
        if (is.available() == 0) return oldImage;

        ServletContext ctx = request.getServletContext(); // 获取文件路径

        String filename = UUID.randomUUID() + "." + FilenameUtils.getExtension(item.getName());
        String image = BASE_DIR + "/" + IMG_DIR + "/" + filename;
        String filepath = ctx.getRealPath(image);
        FileUtils.copyInputStreamToFile(item.getInputStream(), new File(filepath));

        // 删除旧的文件
        // 逻辑判断：如果oldImage是空串，没有这个判断后果是将整个web项目的文件夹给删掉
        if (oldImage != null) {
            // 这里是获取oldImage的全路径后调用FileUtils.deleteQuietly()方法进行删除
            FileUtils.deleteQuietly(new File(ctx.getRealPath(oldImage)));
        }
        return image;
    }

    /**
     * 所有图片参数上传前的参数解析
     * @param request 请求
     * @return 非文件参数params, 文件参数fileParams
     * @throws Exception
     */
    public static UploadParams parseRequest(HttpServletRequest request) throws Exception {
        ServletFileUpload upload = new ServletFileUpload(new DiskFileItemFactory());
        upload.setHeaderEncoding("UTF-8");
        // 一个FileItem就代表一个请求参数（文件参数、非文件参数）
        List<FileItem> items = upload.parseRequest(request);
        // 非文件参数
        Map<String, Object> params = new HashMap<>();
        // 文件参数
        Map<String, FileItem> fileParams = new HashMap<>();
        // 遍历请求参数
        for (FileItem item : items) {
            String fieldName = item.getFieldName();
            if (item.isFormField()) { // 非文件参数
                params.put(fieldName, item.getString("UTF-8"));
            } else { // 文件参数
                fileParams.put(fieldName, item);
            }
        }
        UploadParams uploadParams = new UploadParams();
        uploadParams.setParams(params);
        uploadParams.setFileParams(fileParams);
        return uploadParams;
    }
}
