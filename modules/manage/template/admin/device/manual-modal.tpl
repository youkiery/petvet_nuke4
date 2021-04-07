<!-- BEGIN: main -->
<div class="modal" id="video-modal" role="dialog">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-body">
                <div class="form-group">
                    <b> Danh sách video </b>
                    <div class="close" type="button" data-dismiss="modal"> &times; </div>
                </div>

                <div class="text-center" style="overflow: auto; width: fit-content; margin: auto; position: relative;">
                  <div id="upload-status"></div>
                  <label class="text-center image-box">
                    <img style="width: 100px; height: 100px;" src="/assets/images/upload.png">
                    <div style="width: 50px; height: 50px; display: none;" id="image">
                      <input type="file" id="video" onchange="uploadVideo()" accept=".mp4">
                    </div>
                  </label>
                </div>

                <div id="video-content">
                  {video_content}
                </div>
            </div>
        </div>
    </div>
</div>
<!-- END: main -->