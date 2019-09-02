<?php
  include '/assets/js/PHPMailer/Exception.php';
  include '/assets/js/PHPMailer/OAuth.php';
  include '/assets/js/PHPMailer/PHPMailer.php';
  include '/assets/js/PHPMailer/POP3.php';
  include '/assets/js/PHPMailer/SMTP.php';

  use PHPMailer\PHPMailer\PHPMailer;
  use PHPMailer\PHPMailer\Exception;
  $mail = new PHPMailer(true); 
  try {
    //Server settings
    $mail->SMTPDebug = 2;                                 // Enable verbose debug output
    $mail->isSMTP();                                      // Set mailer to use SMTP
    $mail->Host = 'smtp.gmail.com';  // Specify main and backup SMTP servers
    $mail->SMTPAuth = true;                               // Enable SMTP authentication
    // $mail->Username = 'petcoffee.com@gmail.com';                 // SMTP username
    // $mail->Password = 'petxuan2014';                           // SMTP password
    $mail->Username = 'youkiery@gmail.com';                 // SMTP username
    $mail->Password = 'Gmyk.2511';                           // SMTP password
    $mail->SMTPSecure = 'tsl';                            // Enable TLS encryption, `ssl` also accepted
    $mail->Port = 587;                                    // TCP port to connect to
 
    // //Recipients
    $mail->setFrom('youkiery@gmail.com', 'Mailer');
    $mail->addAddress('youkiery@gmail.com', 'Joe User');     // Add a recipient
    // // $mail->addAddress('ellen@example.com');               // Name is optional
    // // $mail->addReplyTo('info@example.com', 'Information');
    // // $mail->addCC('cc@example.com');
    // // $mail->addBCC('bcc@example.com');
 
    // //Attachments
    // // $mail->addAttachment('/var/tmp/file.tar.gz');         // Add attachments
    // // $mail->addAttachment('/tmp/image.jpg', 'new.jpg');    // Optional name
 
    // //Content
    // $mail->isHTML(true);                                  // Set email format to HTML
    // $mail->Subject = 'Here is the subject';
    $mail->Body    = 'This is the HTML message body <b>in bold!</b>';
    // $mail->AltBody = 'This is the body in plain text for non-HTML mail clients';
 
    $mail->send();
    echo 'Message has been sent';
  } catch (Exception $e) {
    echo 'Message could not be sent. Mailer Error: ', $mail->ErrorInfo;
  }
?>
