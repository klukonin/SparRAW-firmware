/* boot_fill_addr_tables @ 0x8f6584, 1332 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   SYSTEM
 * Зовут его: fw_main
 * Зовёт сам: __ld_r25_to_r13_ret, __st_r25_to_r13
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global boot_fill_addr_tables
boot_fill_addr_tables:
	.global L_8f6584
L_8f6584:
	push_s blink
L_8f6586:
	bl.d L_8c01b8
L_8f658a:
	mov_s r3,0x1
L_8f658c:
	mov_s r14,0x887800
L_8f6592:
	st_s r3,[r14,0x44]
L_8f6594:
	mov_s r13,0x887600
L_8f659a:
	st 0x80000,[r13, 0x44]
L_8f65a2:
	mov_s r2,0x4
L_8f65a4:
	st_s r2,[r14,0x48]
L_8f65a6:
	st 0x300000,[r13, 0x48]
L_8f65ae:
	mov_s r1,0x7
L_8f65b0:
	st_s r1,[r14,0x4c]
L_8f65b2:
	st 0x640000,[r13, 0x4c]
L_8f65ba:
	mov_s r0,0x2
L_8f65bc:
	st_s r0,[r14,0x50]
L_8f65be:
	st 0x880000,[r13, 0x50]
L_8f65c6:
	mov_s r0,0x5
L_8f65c8:
	st_s r0,[r14,0x54]
L_8f65ca:
	st 0xb00000,[r13, 0x54]
L_8f65d2:
	mov_s r15,0x8
L_8f65d4:
	st_s r15,[r14,0x58]
L_8f65d6:
	st 0xe40000,[r13, 0x58]
L_8f65de:
	mov_s r15,0x3
L_8f65e0:
	st_s r15,[r14,0x5c]
L_8f65e2:
	st 0x1080000,[r13, 0x5c]
L_8f65ea:
	mov_s r15,0x6
L_8f65ec:
	st_s r15,[r14,0x60]
L_8f65ee:
	st 0x1300000,[r13, 0x60]
L_8f65f6:
	mov r17,0x9
L_8f65fa:
	st r17,[r14, 0x64]
L_8f65fe:
	st 0x1640000,[r13, 0x64]
L_8f6606:
	mov r23,0xa
L_8f660a:
	st r23,[r14, 0x68]
L_8f660e:
	st 0x1840000,[r13, 0x68]
L_8f6616:
	mov r24,0xb
L_8f661a:
	st r24,[r14, 0x6c]
L_8f661e:
	st 0x1a40000,[r13, 0x6c]
L_8f6626:
	mov r25,0xc
L_8f662a:
	st r25,[r14, 0x70]
L_8f662e:
	st 0x1c40000,[r13, 0x70]
L_8f6636:
	mov r18,0xd
L_8f663a:
	st r18,[r14, 0x74]
L_8f663e:
	st 0x1e40000,[r13, 0x74]
L_8f6646:
	mov r19,0xe
L_8f664a:
	st r19,[r14, 0x78]
L_8f664e:
	st 0x2040000,[r13, 0x78]
L_8f6656:
	mov r20,0xf
L_8f665a:
	st r20,[r14, 0x7c]
L_8f665e:
	st 0x2240000,[r13, 0x7c]
L_8f6666:
	mov r16,0x10
L_8f666a:
	mov_s r14,0x887880
L_8f6670:
	st r16,[r14]
L_8f6674:
	mov_s r13,0x887680
L_8f667a:
	st 0x2480000,[r13]
L_8f6682:
	mov r11,0x11
L_8f6686:
	st r11,[r14, 0x4]
L_8f668a:
	st 0x2680000,[r13, 0x4]
L_8f6692:
	mov r6,0x12
L_8f6696:
	st r6,[r14, 0x8]
L_8f669a:
	st 0x2880000,[r13, 0x8]
L_8f66a2:
	st 0x20013,[r14, 0xc]
L_8f66aa:
	st 0x2a40200,[r13, 0xc]
L_8f66b2:
	mov r5,0x14
L_8f66b6:
	st r5,[r14, 0x10]
L_8f66ba:
	st 0x2c40000,[r13, 0x10]
L_8f66c2:
	mov r4,0x15
L_8f66c6:
	st r4,[r14, 0x14]
L_8f66ca:
	st 0x2e40000,[r13, 0x14]
L_8f66d2:
	mov r7,0x16
L_8f66d6:
	st r7,[r14, 0x18]
L_8f66da:
	st 0x3040000,[r13, 0x18]
L_8f66e2:
	mov r8,0x17
L_8f66e6:
	st r8,[r14, 0x1c]
L_8f66ea:
	st 0x3240000,[r13, 0x1c]
L_8f66f2:
	mov r9,0x18
L_8f66f6:
	st r9,[r14, 0x20]
L_8f66fa:
	st 0x3440000,[r13, 0x20]
L_8f6702:
	mov r10,0x19
L_8f6706:
	st r10,[r14, 0x24]
L_8f670a:
	st 0x3640000,[r13, 0x24]
L_8f6712:
	mov r21,0x1a
L_8f6716:
	st r21,[r14, 0x28]
L_8f671a:
	st 0x3840000,[r13, 0x28]
L_8f6722:
	mov r22,0x1b
L_8f6726:
	st r22,[r14, 0x2c]
L_8f672a:
	st 0x3a40000,[r13, 0x2c]
L_8f6732:
	mov_s r15,0x1c
L_8f6734:
	st.a r15,[sp,-0x20]
L_8f6738:
	st_s r15,[r14,0x30]
L_8f673a:
	st 0x3c40000,[r13, 0x30]
L_8f6742:
	mov_s r15,0x1d
L_8f6744:
	st_s r15,[sp,0x4]
L_8f6746:
	st_s r15,[r14,0x34]
L_8f6748:
	st 0x3e40000,[r13, 0x34]
L_8f6750:
	mov_s r15,0x1e
L_8f6752:
	st_s r15,[sp,0x8]
L_8f6754:
	st_s r15,[r14,0x38]
L_8f6756:
	st 0x4040000,[r13, 0x38]
L_8f675e:
	mov_s r15,0x1f
L_8f6760:
	st_s r15,[sp,0xc]
L_8f6762:
	st_s r15,[r14,0x3c]
L_8f6764:
	st 0x4240000,[r13, 0x3c]
L_8f676c:
	st 0x11820,[r14, 0x40]
L_8f6774:
	st 0x4480002,[r13, 0x40]
L_8f677c:
	mov_s r15,0x21
L_8f677e:
	st_s r15,[sp,0x10]
L_8f6780:
	st_s r15,[r14,0x44]
L_8f6782:
	st 0x4640000,[r13, 0x44]
L_8f678a:
	mov_s r15,0x22
L_8f678c:
	st_s r15,[sp,0x14]
L_8f678e:
	st_s r15,[r14,0x48]
L_8f6790:
	st 0x4840000,[r13, 0x48]
L_8f6798:
	mov_s r15,0x23
L_8f679a:
	st_s r15,[sp,0x18]
L_8f679c:
	st_s r15,[r14,0x4c]
L_8f679e:
	st 0x4a40000,[r13, 0x4c]
L_8f67a6:
	mov_s r15,0x24
L_8f67a8:
	st_s r15,[sp,0x1c]
L_8f67aa:
	st_s r15,[r14,0x50]
L_8f67ac:
	st 0x4c40000,[r13, 0x50]
L_8f67b4:
	mov_s r15,0x25
L_8f67b6:
	st_s r15,[r14,0x54]
L_8f67b8:
	st 0x4e40000,[r13, 0x54]
L_8f67c0:
	mov_s r15,0x26
L_8f67c2:
	st_s r15,[r14,0x58]
L_8f67c4:
	st 0x5040000,[r13, 0x58]
L_8f67cc:
	mov_s r15,0x27
L_8f67ce:
	st_s r15,[r14,0x5c]
L_8f67d0:
	st 0x5240000,[r13, 0x5c]
L_8f67d8:
	st 0x20028,[r14, 0x60]
L_8f67e0:
	st 0x5441200,[r13, 0x60]
L_8f67e8:
	st 0x20029,[r14, 0x64]
L_8f67f0:
	st 0x5642200,[r13, 0x64]
L_8f67f8:
	st 0x2002a,[r14, 0x68]
L_8f6800:
	st 0x5843200,[r13, 0x68]
L_8f6808:
	st 0x2002b,[r14, 0x6c]
L_8f6810:
	st 0x5a44200,[r13, 0x6c]
L_8f6818:
	mov_s r13,0x887380
L_8f681e:
	st_s r3,[r13,0x44]
L_8f6820:
	mov_s r3,0x887100
L_8f6826:
	st 0x40000,[r3, 0x44]
L_8f682e:
	st_s r2,[r13,0x48]
L_8f6830:
	st 0x240000,[r3, 0x48]
L_8f6838:
	st_s r0,[r13,0x4c]
L_8f683a:
	st 0x440000,[r3, 0x4c]
L_8f6842:
	st_s r1,[r13,0x50]
L_8f6844:
	st 0x640000,[r3, 0x50]
L_8f684c:
	st r17,[r13, 0x54]
L_8f6850:
	st 0x840000,[r3, 0x54]
L_8f6858:
	st r23,[r13, 0x58]
L_8f685c:
	st 0xa40000,[r3, 0x58]
L_8f6864:
	st r24,[r13, 0x5c]
L_8f6868:
	st 0xc40000,[r3, 0x5c]
L_8f6870:
	st r25,[r13, 0x60]
L_8f6874:
	st 0xe40000,[r3, 0x60]
L_8f687c:
	st r18,[r13, 0x64]
L_8f6880:
	st 0x1040000,[r3, 0x64]
L_8f6888:
	st r19,[r13, 0x68]
L_8f688c:
	st 0x1240000,[r3, 0x68]
L_8f6894:
	st r20,[r13, 0x6c]
L_8f6898:
	st 0x1440000,[r3, 0x6c]
L_8f68a0:
	st r16,[r13, 0x70]
L_8f68a4:
	st 0x1640000,[r3, 0x70]
L_8f68ac:
	st r11,[r13, 0x74]
L_8f68b0:
	st 0x1840000,[r3, 0x74]
L_8f68b8:
	st r6,[r13, 0x78]
L_8f68bc:
	st 0x1a40000,[r3, 0x78]
L_8f68c4:
	mov_s r0,0x13
L_8f68c6:
	st_s r0,[r13,0x7c]
L_8f68c8:
	st 0x1c40000,[r3, 0x7c]
L_8f68d0:
	mov_s r2,0x887400
L_8f68d6:
	st r5,[r2]
L_8f68da:
	mov_s r1,0x887180
L_8f68e0:
	st 0x1e40000,[r1]
L_8f68e8:
	st r4,[r2, 0x4]
L_8f68ec:
	st 0x2040000,[r1, 0x4]
L_8f68f4:
	st r7,[r2, 0x8]
L_8f68f8:
	st 0x2240000,[r1, 0x8]
L_8f6900:
	st r8,[r2, 0xc]
L_8f6904:
	st 0x2440000,[r1, 0xc]
L_8f690c:
	st r9,[r2, 0x10]
L_8f6910:
	st 0x2640000,[r1, 0x10]
L_8f6918:
	st r10,[r2, 0x14]
L_8f691c:
	st 0x2840000,[r1, 0x14]
L_8f6924:
	st r21,[r2, 0x18]
L_8f6928:
	st 0x2a40000,[r1, 0x18]
L_8f6930:
	st r22,[r2, 0x1c]
L_8f6934:
	st 0x2c40000,[r1, 0x1c]
L_8f693c:
	ld_s r0,[sp,0x0]
L_8f693e:
	st_s r0,[r2,0x20]
L_8f6940:
	st 0x2e40000,[r1, 0x20]
L_8f6948:
	ld_s r0,[sp,0x4]
L_8f694a:
	st_s r0,[r2,0x24]
L_8f694c:
	st 0x3040000,[r1, 0x24]
L_8f6954:
	ld_s r0,[sp,0x8]
L_8f6956:
	st_s r0,[r2,0x28]
L_8f6958:
	st 0x3240000,[r1, 0x28]
L_8f6960:
	ld_s r0,[sp,0xc]
L_8f6962:
	st_s r0,[r2,0x2c]
L_8f6964:
	st 0x3440000,[r1, 0x2c]
L_8f696c:
	mov_s r0,0x20
L_8f696e:
	st_s r0,[r2,0x30]
L_8f6970:
	st 0x3640000,[r1, 0x30]
L_8f6978:
	ld_s r0,[sp,0x10]
L_8f697a:
	st_s r0,[r2,0x34]
L_8f697c:
	st 0x3840000,[r1, 0x34]
L_8f6984:
	ld_s r0,[sp,0x14]
L_8f6986:
	st_s r0,[r2,0x38]
L_8f6988:
	st 0x3a40000,[r1, 0x38]
L_8f6990:
	ld_s r0,[sp,0x18]
L_8f6992:
	st_s r0,[r2,0x3c]
L_8f6994:
	st 0x3c40000,[r1, 0x3c]
L_8f699c:
	ld_s r0,[sp,0x1c]
L_8f699e:
	st_s r0,[r2,0x40]
L_8f69a0:
	st 0x3e40000,[r1, 0x40]
L_8f69a8:
	mov_s r0,0x2a
L_8f69aa:
	st_s r0,[r2,0x44]
L_8f69ac:
	st 0x4040000,[r1, 0x44]
L_8f69b4:
	mov_s r0,0x2b
L_8f69b6:
	st_s r0,[r2,0x48]
L_8f69b8:
	st 0x4240000,[r1, 0x48]
L_8f69c0:
	mov_s r0,0x2c
L_8f69c2:
	st_s r0,[r2,0x4c]
L_8f69c4:
	st 0x4440000,[r1, 0x4c]
L_8f69cc:
	mov_s r0,0x2d
L_8f69ce:
	st_s r0,[r2,0x50]
L_8f69d0:
	st 0x4640000,[r1, 0x50]
L_8f69d8:
	mov_s r0,0x2e
L_8f69da:
	st_s r0,[r2,0x54]
L_8f69dc:
	st 0x4840000,[r1, 0x54]
L_8f69e4:
	mov_s r0,0x2f
L_8f69e6:
	st_s r0,[r2,0x58]
L_8f69e8:
	st 0x4a40000,[r1, 0x58]
L_8f69f0:
	mov_s r0,0x30
L_8f69f2:
	st_s r0,[r2,0x5c]
L_8f69f4:
	st 0x4c40000,[r1, 0x5c]
L_8f69fc:
	mov_s r0,0x32
L_8f69fe:
	st_s r0,[r2,0x60]
L_8f6a00:
	st 0x4e40000,[r1, 0x60]
L_8f6a08:
	mov_s r0,0x33
L_8f6a0a:
	st_s r0,[r2,0x64]
L_8f6a0c:
	st 0x5040000,[r1, 0x64]
L_8f6a14:
	mov_s r0,0x34
L_8f6a16:
	st_s r0,[r2,0x68]
L_8f6a18:
	st 0x52c0000,[r1, 0x68]
L_8f6a20:
	mov_s r0,0x36
L_8f6a22:
	st_s r0,[r2,0x6c]
L_8f6a24:
	st 0x5640000,[r1, 0x6c]
L_8f6a2c:
	mov_s r0,0x37
L_8f6a2e:
	st_s r0,[r2,0x70]
L_8f6a30:
	st 0x5840000,[r1, 0x70]
L_8f6a38:
	mov_s r0,0x39
L_8f6a3a:
	st_s r0,[r2,0x74]
L_8f6a3c:
	st 0x5a40000,[r1, 0x74]
L_8f6a44:
	mov_s r0,0x3a
L_8f6a46:
	st_s r0,[r2,0x78]
L_8f6a48:
	st 0x5c40000,[r1, 0x78]
L_8f6a50:
	mov_s r0,0x3b
L_8f6a52:
	st_s r0,[r2,0x7c]
L_8f6a54:
	st 0x5ec0000,[r1, 0x7c]
L_8f6a5c:
	mov_s r0,0x3d
L_8f6a5e:
	mov_s r2,0x887480
L_8f6a64:
	st_s r0,[r2]
L_8f6a66:
	mov_s r1,0x887200
L_8f6a6c:
	st 0x6240000,[r1]
L_8f6a74:
	mov_s r0,0x3e
L_8f6a76:
	st_s r0,[r2,0x4]
L_8f6a78:
	st 0x6440000,[r1, 0x4]
L_8f6a80:
	mov_s r0,0x40
L_8f6a82:
	st_s r0,[r2,0x8]
L_8f6a84:
	st 0x6640000,[r1, 0x8]
L_8f6a8c:
	mov_s r0,0x41
L_8f6a8e:
	st_s r0,[r2,0xc]
L_8f6a90:
	st 0x6840000,[r1, 0xc]
L_8f6a98:
	mov_s r0,0x42
L_8f6a9a:
	st_s r0,[r2,0x10]
L_8f6a9c:
	st 0x6a40000,[r1, 0x10]
L_8f6aa4:
	mov_s r0,0x45
L_8f6aa6:
	st_s r0,[r2,0x14]
L_8f6aa8:
	st 0x6c40000,[r1, 0x14]
L_8f6ab0:
	b.d L_8c01fc
L_8f6ab4:
	add_s sp,sp,0x20
L_8f6ab6:
	nop_s
