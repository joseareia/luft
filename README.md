## Luft: IoT Environment Adversary Suite
[![made-with-bash](https://img.shields.io/badge/Made%20with-Bash-1f425f.svg?color=green)](https://www.latex-project.org/)
[![GitHub license](https://img.shields.io/badge/License-GPL_3.0-green.svg)](https://www.gnu.org/licenses/gpl-3.0.en.html#license-text)
[![Release](https://img.shields.io/badge/Release-v1.0.0-green.svg)](https://github.com/joseareia/luft/releases)
[![Maintenance](https://img.shields.io/badge/Maintained%3F-Yes-green.svg)](https://github.com/joseareia/luft/graphs/commit-activity)

### Description
Luft is a versatile suite for generating adversarial attacks within an IoT environment. Supported by six distinct attacks, it allows us to define the target address and loop attacks for better performance. The currently supported attacks are: Slow Loris, Slow Read, R-U-Dead-Yet (RUDY), Apache Killer, Network Scanning, and MACOF.

<p float="left">
  <img src="https://github.com/joseareia/luft/blob/master/Assets/Luft.png"/>
</p>

### Usage

```
$ luft [options] [arguments]
```

#### Arguments
- `-h`, `--help`: Display detailed help and usage information for the given command.
- `-t`, `--target`: Specify the target IP address for the attack.
- `-i`, `--interface`: Specify the network interface for the attack. This option is only applicable for the MACOF attack.
- `-l`, `--loop`: Repeat the attack a specified number of times.

#### Main Options
- `slowloris`: Performs the Slow Loris attack.
- `slowread`: Performs the Slow Read attack. 
- `rudy`: Performs the R-U-Dead-Yet (RUDY) attack. 
- `apachekiller`: Performs the Apache Killer attack. 
- `macof`: Performs the MACOF attack. 
- `netscan`: Performs the Networking Scanning attack. 

#### Secondary Options 
- `about`: Shows short information about Luft.
- `list`: List all commands and useful information. 

### Getting Help
If you have any questions regarding this suite, its usage, or encounter any errors you're struggling with, please feel free to open an issue in this repository, or contact me via email at <a href="mailto:jose.apareia@gmail.com">jose.apareia@gmail.com</a>.

### Contributing
Contributions to this suite are welcome! If you encounter any issues, have suggestions for improvements, or would like to add new features, please submit a pull request. We appreciate your feedback and contributions to make this suite even better.

### License
This project is under the [GPL 3.0](https://www.gnu.org/licenses/gpl-3.0.en.html#license-text) license.
