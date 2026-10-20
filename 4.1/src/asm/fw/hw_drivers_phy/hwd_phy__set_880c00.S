/* hwd_phy__set_880c00 @ 0x8cf07c, 104 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   hw_drivers_phy.c
 * Зовут его: hw_modes__apply_power_mode, hwd_phy__power_up_seq
 * Зовёт сам: __ld_r13_ret, fw_sysassert_fatal
 */
	.section .text.hwd_phy__set_880c00,"ax",@progbits
	.global hwd_phy__set_880c00
hwd_phy__set_880c00:
	.global L_8cf07c
L_8cf07c:
	push_s blink
L_8cf07e:
	push_s r13
L_8cf080:
	brhs.d r0,0x5,L_8cf098
L_8cf084:
	mov_s r13,r0
L_8cf086:
	ldb.x r10,[0x803094,r13]
L_8cf08e:
	add r0,pcl,0xc
L_8cf092:
	add1 r0,r0,r10
L_8cf096:
	j_s [r0]
	.global L_8cf098
L_8cf098:
	mov_s r0,blink
L_8cf09a:
	mov_s r2,0x1018690
L_8cf0a0:
	mov_s r1,0x12da
L_8cf0a6:
	bl.d L_8c82c0
L_8cf0aa:
	mov r3,0x536
L_8cf0ae:
	asl_s r1,r13,0x4
L_8cf0b0:
	or_s r1,r1,r13
L_8cf0b2:
	asl r0,r13,0x8
L_8cf0b6:
	or_s r0,r0,r1
L_8cf0b8:
	asl r1,r13,0xc
L_8cf0bc:
	or_s r1,r1,r0
L_8cf0be:
	asl r0,r13,0x10
L_8cf0c2:
	or_s r0,r0,r1
L_8cf0c4:
	asl r1,r13,0x14
L_8cf0c8:
	or_s r1,r1,r0
L_8cf0ca:
	asl r0,r13,0x18
L_8cf0ce:
	or_s r0,r0,r1
L_8cf0d0:
	asl_s r13,r13,0x1c
L_8cf0d2:
	or_s r0,r0,r13
L_8cf0d4:
	mov_s r1,0x880c00
L_8cf0da:
	st_s r0,[r1,0x4]
L_8cf0dc:
	bmsk_s r0,r0,0x1b
L_8cf0de:
	st_s r0,[r1,0x8]
L_8cf0e0:
	b L_8c033c
