; Make sure to include the other file in /Library/


!Eats = 3

main:
    ldy.b #(5-!Eats)
    jsl BabyYoshiEats_Library_main
    rtl
