<?php

date_default_timezone_set('Europe/London');

class Deploy {

    /**
     * A callback function to call after the deploy has finished.
     *
     * @var callback
     */
    public $post_deploy;

    /**
     * The name of the file that will be used for logging deployments. Set to
     * FALSE to disable logging.
     *
     * @var string
     */
    private $_log = 'deployments.log';

    /**
     * The timestamp format used for logging.
     *
     * @link    http://www.php.net/manual/en/function.date.php
     * @var     string
     */
    private $_date_format = 'Y-m-d H:i:sP';

    /**
     * The name of the branch to pull from.
     *
     * @var string
     */
    private $_branch = 'master';

    /**
     * The name of the remote to pull from.
     *
     * @var string
     */
    private $_remote = 'origin';

    /**
     * The directory where your website and git repository are located, can be
     * a relative or absolute path
     *
     * @var string
     */
    private $_directory;

    /**
     * Sets up defaults.
     *
     * @param  string  $directory  Directory where your website is located
     * @param  array   $data       Information about the deployment
     */
    public function __construct($directory, $options = array())
    {
        // Determine the directory path
        $this->_directory = realpath($directory).DIRECTORY_SEPARATOR;

        $available_options = array('log', 'date_format', 'branch', 'remote');

        foreach ($options as $option => $value)
        {
            if (in_array($option, $available_options))
            {
                $this->{'_'.$option} = $value;
            }
        }

        $this->log('Attempting deployment...');
    }

    /**
     * Writes a message to the log file.
     *
     * @param  string  $message  The message to write
     * @param  string  $type     The type of log message (e.g. INFO, DEBUG, ERROR, etc.)
     */
    public function log($message, $type = 'INFO')
    {
        if ($this->_log)
        {
            // Set the name of the log file
            $filename = $this->_log;

            if ( ! file_exists($filename))
            {
                // Create the log file
                file_put_contents($filename, '');

                // Allow anyone to write to log files
                chmod($filename, 0666);
            }

            // Write the message into the log file
            // Format: time --- type: message
            file_put_contents($filename, date($this->_date_format).' --- '.$type.': '.$message.PHP_EOL, FILE_APPEND);
        }
    }

    /**
     * Executes the necessary commands to deploy the website.
     */
    public function execute()
    {
        try
        {
            // Make sure we're in the right directory
            chdir($this->_directory);
            $this->log('Changing working directory... ');

            // Discard any changes to tracked files since our last deploy
            exec('git reset --hard HEAD', $output);
            $this->log('Reseting repository... '.implode(' ', $output));

            // Update the local repository
            exec('git pull '.$this->_remote.' '.$this->_branch, $output);
            $this->log('Pulling in changes... '.implode(' ', $output));

            // Secure the .git directory
            exec('chmod -R og-rx .git');
            $this->log('Securing .git directory... ');

            if (is_callable($this->post_deploy))
            {
                call_user_func($this->post_deploy, $this->_data);
            }

            $this->log('Deployment successful.');
        }
        catch (Exception $e)
        {
            $this->log($e, 'ERROR');
        }
    }



public function go() {
    // webhook上设置的secret
    $secret = "iimT";

    // 校验发送位置，正确的情况下自动拉取代码，实现自动部署
    $signature = $_SERVER['HTTP_X_HUB_SIGNATURE'];
    if ($signature) {
        $hash = "sha1=".hash_hmac('sha1', file_get_contents("php://input"), $secret);
        if (strcmp($signature, $hash) == 0) {
            // sign sucess

            set_time_limit(3 * 60); //最大过期时间3分钟
            $shellPath = "/home/www/T-Blog";
            $cmd = "cd $shellPath && sudo git pull && sudo /bin/bash CI.sh";
            $res = $this -> doShell($cmd);
            print_r($res); // 主要打印结果给github记录查看，自己测试时查看

        }
    }
}

/*
 * 执行shell命令
 */
protected function doShell ($cmd, $cwd = null) {
    $descriptorspec = array(
        0 => array("pipe", "r"), // stdin
        1 => array("pipe", "w"), // stdout
        2 => array("pipe", "w"), // stderr
    );
    $proc = proc_open($cmd, $descriptorspec, $pipes, $cwd, null);
    // $proc为false，表明命令执行失败
    if ($proc == false) {
        return false;
        // do sth with HTTP response
        print_r("命令执行出错！");
    } else {
        $stdout = stream_get_contents($pipes[1]);
        fclose($pipes[1]);
        $stderr = stream_get_contents($pipes[2]);
        fclose($pipes[2]);
        $status = proc_close($proc); // 释放proc
    }
    $data = array(
        'stdout' => $stdout, // 标准输出
        'stderr' => $stderr, // 错误输出
        'retval' => $status, // 返回值
    );

    return $data;
}


}

// This is just an example
$deploy = new Deploy('/root/wordpress/html/sysinit/');

$deploy->go();

?>
