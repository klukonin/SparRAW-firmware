/* hwd_mac__rgf_886200 @ 0x8ce260, 52 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   hw_drivers_mac.c
 * Зовут его: calib_lo_power_step, hwf_calib__restore_path
 * Зовёт сам: __ld_r13_ret, fw_sysassert_fatal
 */
	.section .text.hwd_mac__rgf_886200,"ax",@progbits
	.global hwd_mac__rgf_886200
hwd_mac__rgf_886200:
	.global L_8ce260
L_8ce260:
	push_s blink
L_8ce262:
	push_s r13
L_8ce264:
	mov_s r13,r0
L_8ce266:
	bclr.f r0,r0,0x0
L_8ce26a:
	bne_s L_8ce280
	.global L_8ce26c
L_8ce26c:
	mov_s r1,0x886200
L_8ce272:
	ld_s r0,[r1]
L_8ce274:
	asl_s r13,r13,0xb
L_8ce276:
	bclr_s r0,r0,0xb
L_8ce278:
	or_s r13,r13,r0
L_8ce27a:
	st_s r13,[r1]
L_8ce27c:
	b L_8c033c
	.global L_8ce280
L_8ce280:
	mov_s r0,blink
L_8ce282:
	mov_s r2,0x1019e38
L_8ce288:
	mov_s r1,0xac
L_8ce28a:
	bl.d L_8c82c0
L_8ce28e:
	mov r3,0x108
L_8ce292:
	b_s L_8ce26c
