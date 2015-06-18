<?php
    
    // Put your device token here (without spaces):
//    $deviceToken = '9597900d537cbc4aebce3b8fecb71d3ba7ef7965b87ebf3f7c753dd356056b1d';
    $deviceToken = 'd58d687bb1652e666e8f0f27976a822b8f548d355856a9006be56b303f6b8932';
    
    // Put your private key's passphrase here:
    $passphrase = 'abcabc';
    
    // Put your alert message here:
    $message = '吃饭了!';
    
    ////////////////////////////////////////////////////////////////////////////////
    
    $ctx = stream_context_create();
    stream_context_set_option($ctx, 'ssl', 'local_cert', 'ck.pem');
    stream_context_set_option($ctx, 'ssl', 'passphrase', $passphrase);
    
    // Open a connection to the APNS server
    $fp = stream_socket_client("ssl://gateway.sandbox.push.apple.com:2195", $err, $errstr, 60, STREAM_CLIENT_CONNECT, $ctx);
//    $fp = stream_socket_client("ssl://gateway.push.apple.com:2195", $err, $errstr, 60, STREAM_CLIENT_CONNECT, $ctx);
    
    if (!$fp)
	exit("Failed to connect: $err $errstr" . PHP_EOL);
    
    echo 'Connected to APNS' . PHP_EOL;
    
    // Create the payload body
    $body['aps'] = array(
                         'alert' => $message,
                         'sound' => 'default',
                         'badge' => 1
                         );
	
    //消息内容
    $body['userinfo']=array('create_time' => (int)1416252738,
                            'groupid' => (int)19,
                            'message' => "推送内容测试",
                            'notificationId' => (int)2001,
                            'title' => "推送标题100",
                            'type' => (int)5,
                            'user' => (int)549,
                            'usertype' => (int)1,
                            'content' => array('id' => (int)454,
                                  'type' => (int)1
                                  )
                            );
    
    // Encode the payload as JSON
    $payload = json_encode($body);
    
    // Build the binary notification
    $msg = chr(0) . pack('n', 32) . pack('H*', $deviceToken) . pack('n', strlen($payload)) . $payload;
    
    // Send it to the server
    $result = fwrite($fp, $msg, strlen($msg));
    
    if (!$result)
	echo 'Message not delivered' . PHP_EOL;
    else
	echo 'Message successfully delivered' . PHP_EOL;
    
    // Close the connection to the server
    fclose($fp);
?>
