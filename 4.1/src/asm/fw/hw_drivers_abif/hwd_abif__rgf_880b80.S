/* hwd_abif__rgf_880b80 @ 0x8cd230, 76 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   hw_drivers_abif.c
 * Зовут его: hw_modes__apply_power_mode
 * Зовёт сам: __ld_r13_ret, fw_sysassert_fatal
 */
	.section .text.hwd_abif__rgf_880b80,"ax",@progbits
	.global hwd_abif__rgf_880b80
hwd_abif__rgf_880b80:
	.global L_8cd230
L_8cd230:
	push_s blink
L_8cd232:
	push_s r13
L_8cd234:
	brhs.d r0,0x5,L_8cd24c
L_8cd238:
	mov_s r13,r0
L_8cd23a:
	ldb.x r10,[0x8030e0,r13]
L_8cd242:
	add r0,pcl,0xc
L_8cd246:
	add1 r0,r0,r10
L_8cd24a:
	j_s [r0]
	.global L_8cd24c
L_8cd24c:
	mov_s r0,blink
L_8cd24e:
	mov_s r2,0x1019954
L_8cd254:
	mov_s r1,0x12d7
L_8cd25a:
	bl.d L_8c82c0
L_8cd25e:
	mov r3,0x75b
L_8cd262:
	asl_s r1,r13,0x4
L_8cd264:
	or_s r13,r13,r1
L_8cd266:
	mov_s r1,0x880b80
L_8cd26c:
	ld_s r0,[r1,0x70]
L_8cd26e:
	extb_s r13,r13
L_8cd270:
	bic r0,r0,0xff
L_8cd274:
	or_s r0,r0,r13
L_8cd276:
	st_s r0,[r1,0x70]
L_8cd278:
	b L_8c033c
