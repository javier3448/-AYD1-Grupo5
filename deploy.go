package main

// Solo funciona para linux (que yo sepa)
// @TODO: escribir las dependencias

import (
    "fmt"
    "os"
    "os/exec"
    "log"
)

// @TODO: que pasa si el ejecutable no existe, como puedo sacar un error razonable
//        de eso?

func main() {
    // Note that the first value of the os.Args slice is the path to the program, 
    // and os.Args[1:] holds the arguments to the program. 
    args := os.Args[1:]

    if(len(args) != 1){
        log.Fatalf("\nSe requiere al menos 1 argumento que indique el nombre de la branch a la que se le hara deployment.\nEjemplo: go run deploy.go develop")
    }
    // Poco seguro: si ponen el nombre de brach como: "develop ; comandoMaligno",
    // no se si go nos protege de ese tipo de expansiones y no es como que este 
    // script lo pueda correr alguien que no tenga acceso a la shell
    nombreDeBranch := args[0];

    {// para y eliminar el proceso del node anterior y limpiar los logs
        cmd := exec.Command("pm2", "delete", "all")
        stdoutAndStderr, err := cmd.CombinedOutput()
        fmt.Println("****SALIDA DE `pm2 delete all`")
        fmt.Printf("%s\n", stdoutAndStderr)
        if err != nil {
            log.Fatal("nothing")
        }
    }

    {// limpiar los logs
        cmd := exec.Command("pm2", "flush")
        stdoutAndStderr, err := cmd.CombinedOutput()
        fmt.Println("****SALIDA DE `pm2 flush`")
        fmt.Printf("%s\n", stdoutAndStderr)
        if err != nil {
            log.Fatal(err)
        }
    }

    {// eliminar repo
        cmd := exec.Command("rm", "-rf", "./-AYD1-Grupo5")
        stdoutAndStderr, err := cmd.CombinedOutput()
        fmt.Println("****SALIDA DE `rm -rf ./-AYD1-Grupo5`")
        fmt.Printf("%s\n", stdoutAndStderr)
        if err != nil {
            log.Fatal(err)
        }
    }

    {// clonar el repo
        cmd := exec.Command("git", "clone", "https://github.com/javier3448/-AYD1-Grupo5.git")
        stdoutAndStderr, err := cmd.CombinedOutput()
        fmt.Println("****SALIDA git clone https://github.com/javier3448/-AYD1-Grupo5.git")
        fmt.Printf("%s\n", stdoutAndStderr)
        if err != nil {
            log.Fatal(err)
        }
    }

    {// checkout
        cmd := exec.Command("git", "checkout", nombreDeBranch)

        // [!!!]: este comando lo ejecutamos en otro path
        cmd.Path = "./-AYD1-Grupo5";

        stdoutAndStderr, err := cmd.CombinedOutput()
        fmt.Printfln("****SALIDA git checkout %s", nombreDeBranch)
        fmt.Printf("%s\n", stdoutAndStderr)
        if err != nil {
            log.Fatal(err)
        }
    }

    {// instalamos los modulos de node
        cmd := exec.Command("npm", "install")

        // [!!!]: este comando lo ejecutamos en otro path
        cmd.Path = "./-AYD1-Grupo5/backend";

        stdoutAndStderr, err := cmd.CombinedOutput()
        fmt.Printfln("****SALIDA npm install %s")
        fmt.Printf("%s\n", stdoutAndStderr)
        if err != nil {
            log.Fatal(err)
        }
    }

    {// corremos app con pm2
        cmd := exec.Command("pm2", "start", "index.js")

        // [!!!]: este comando lo ejecutamos en otro path
        cmd.Path = "./-AYD1-Grupo5/backend/src";

        stdoutAndStderr, err := cmd.CombinedOutput()
        fmt.Printfln("****SALIDA pm2 start index.js")
        fmt.Printf("%s\n", stdoutAndStderr)
        if err != nil {
            log.Fatal(err)
        }
    }

    fmt.Println(nombreDeBranch)
}
