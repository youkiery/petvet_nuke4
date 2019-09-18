<style>
  #review {
    width: 25%;
    padding: 20px;
    position: fixed;
    bottom: 0px;
    right: 0px;
    border: 1px solid lightgray;
    border-top-left-radius: 20px;
    background: white;
  }

  #review-bar {
    height: 30px;
    width: 25%;
    position: fixed;
    bottom: 0px;
    right: 0px;
    border: 1px solid lightgray;
    background: cornflowerblue;
  }

  @media (max-width: 876px) {
    #review, #review-bar {
      width: 300px;
    }
  }
</style>
<div id="review" style="display: none;">
  <div style="position: absolute; top: 0px; left: 0px; width: -webkit-fill-available; height: 20px; background: cornflowerblue; border-top-left-radius: 20px;" onclick="hideReview()"></div>
  <form onsubmit="sendReview(event)" style="margin-top: 10px;">

    <input type="text" class="form-control" id="review-username" placeholder="Tên hiển thị">
    <div class="text-center">
      Nội dung
      <textarea class="form-control" id="review-content" rows="5"></textarea>
      <button class="btn btn-info">
        Gửi góp ý
      </button>
    </div>
  </form>
</div>
<div id="review-bar" class="text-center" style="color: white; font-weight: bold; line-height: 30px;" onclick="showReview()">
  Góp ý
</div>

<script>
  function hideReview() {
    $("#review").hide()
    $("#review-bar").show()
  }

  function showReview() {
    $("#review").show()
    $("#review-bar").hide()
  }

  function sendReview(e) {
    e.preventDefault()
    $.post(
      '/news/review/',
      {action: 'send-review', username: $("#review-name").val(), content: $("#review-content").val()},
      (response, status) => {
        checkResult(response, status).then(data => {
          console.log('success');
        }, () => {})
      }
    )
  }
</script>
