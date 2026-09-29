/* ucode_cmd_0x22_handler @ 0x92e840, 104 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: ucode_cmd_dispatch
 * Зовёт сам: uc_sysassert
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global ucode_cmd_0x22_handler
ucode_cmd_0x22_handler:
	.global L_92e840
L_92e840:
	mov_s r1,r0
L_92e842:
	mov_s r0,0x802f80
L_92e848:
	b L_92e84c
	.global L_92e84c
L_92e84c:
	st.a r13,[sp,-0x10]
L_92e850:
	st blink,[sp, 0x4]
L_92e854:
	st_s r14,[sp,0x8]
L_92e856:
	st_s r15,[sp,0xc]
L_92e858:
	ldb_s r13,[r1]
L_92e85a:
	mov_s r15,r1
L_92e85c:
	cmp r13,0xff
L_92e860:
	mov r14,r0
L_92e864:
	beq.d L_92e878
L_92e868:
	add.eq r14,r14,0x2c
L_92e86c:
	brhs r13,0x8,L_92e898
	.global L_92e870
L_92e870:
	/* asl_s r13,r13,0x4 */
	.byte 0x04,0xbd
L_92e872:
	add r14,r14,0xa8
L_92e876:
	add_s r14,r14,r13
	.global L_92e878
L_92e878:
	ldb_s r2,[r15,0x1]
L_92e87a:
	mov_s r3,0x1
L_92e87c:
	stb_s r2,[r14,0x4]
L_92e87e:
	ld_s r1,[r15,0x4]
L_92e880:
	ld_s r0,[r15,0x8]
L_92e882:
	st_s r1,[r14,0x8]
L_92e884:
	st_s r0,[r14,0xc]
L_92e886:
	st_s r3,[r14]
L_92e888:
	ld blink,[sp, 0x4]
L_92e88c:
	ld_s r14,[sp,0x8]
L_92e88e:
	ld_s r15,[sp,0xc]
L_92e890:
	j.d [blink]
L_92e894:
	ld.ab r13,[sp,0x10]
	.global L_92e898
L_92e898:
	mov_s r0,blink
L_92e89a:
	mov_s r1,0x1481
L_92e8a0:
	bl L_926618
L_92e8a4:
	b_s L_92e870
L_92e8a6:
	nop_s
