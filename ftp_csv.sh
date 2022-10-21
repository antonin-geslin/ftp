i=2
j=$(wc -l <Shell_Users.csv)  
j=$((j+2))
#echo $j
addgroup FTPusers
while [ $i != $j ]      
do
    #sed -n $i'p' Shell_Userlist.csv
    sed -n $i'p' Shell_Userlist.csv > temp.txt        
    if grep -q 'Admin' temp.txt
    then
        nom=$(cut -d ',' -f 2 temp.txt)    
        mdp=$(cut -d ',' -f 4 temp.txt)

        echo -ne "$mdp\n$mdp\n" | adduser --force-badname $nom 
        usermod -aG sudo $nom
        adduser $nom FTPusers
    else
        nom=$(cut -d ',' -f 2 temp.txt)     
        mdp=$(cut -d ',' -f 4 temp.txt)       

         echo -ne "$mdp\n$mdp\n" | adduser --force-name $nom
         adduser $nom FTPusers
    fi
    i=$((i+1))
done
rm temp.txt