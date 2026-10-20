/* hwd_abif__get_88af80 @ 0x8cb90c, 64 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   hw_drivers_abif.c
 * Зовут его: hwf_calib__acquire_hw
 * Зовёт сам: __ld_r13_ret, fw_sysassert_fatal
 */
	.section .text.hwd_abif__get_88af80,"ax",@progbits
	.global hwd_abif__get_88af80
hwd_abif__get_88af80:
	.global L_8cb90c
L_8cb90c:
	push_s blink
L_8cb90e:
	push_s r13
L_8cb910:
	mov_s r0,0x88af80
L_8cb916:
	ld_s r13,[r0,0x70]
L_8cb918:
	bmsk_s r13,r13,0x4
L_8cb91a:
	sub_s r1,r13,0x1
L_8cb91c:
	brhs r1,0x10,L_8cb930
L_8cb920:
	ldb.x r1,[0x8030c0,r1]
L_8cb928:
	add r0,pcl,0x8
L_8cb92c:
	add1_s r0,r0,r1
L_8cb92e:
	j_s [r0]
	.global L_8cb930
L_8cb930:
	mov_s r0,blink
L_8cb932:
	mov_s r2,0x1019954
L_8cb938:
	mov_s r1,0xad
L_8cb93a:
	bset_s r1,r1,0xc
L_8cb93c:
	bl.d L_8c82c0
L_8cb940:
	mov r3,0x1df
L_8cb944:
	b.d L_8c033c
L_8cb948:
	mov_s r0,r13
L_8cb94a:
	nop_s
