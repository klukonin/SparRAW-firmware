/* sysassert__dump_ucode_int6 @ 0x8c84ac, 96 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   uCode INT6 additional info: MAC_SXD.MAC_HW_ICR 0x%08x
 *   ucode WatchDog!!!!!
 *   FA rates: previous=%d[FA/ms] current=%d[FA/ms]
 * Зовут его: fw_sysassert_fatal
 * Зовёт сам: __ld_r13_ret, fw_log__emit0, fw_log__emit1, fw_log__emit2
 */
	.section .text.sysassert__dump_ucode_int6,"ax",@progbits
	.global sysassert__dump_ucode_int6
sysassert__dump_ucode_int6:
	.global L_8c84ac
L_8c84ac:
	push_s blink
L_8c84ae:
	push_s r13
L_8c84b0:
	mov_s r13,0x857000
L_8c84b6:
	ld_s r0,[r13,0x28]
L_8c84b8:
	breq r0,0x26,L_8c84c6
L_8c84bc:
	breq r0,0x29,L_8c84de
L_8c84c0:
	breq r0,0x2b,L_8c84f6
L_8c84c4:
	b_s L_8c850a
	.global L_8c84c6
L_8c84c6:
	mov_s r3,0x886e00
L_8c84cc:
	ld_s r3,[r3,0x24]
L_8c84ce:
	mov_s r2,0x1001450
L_8c84d4:
	mov_s r0,0x0
L_8c84d6:
	bl.d L_8edfcc
L_8c84da:
	mov_s r1,r0
L_8c84dc:
	b_s L_8c850a
	.global L_8c84de
L_8c84de:
	mov_s r2,0x1001488
L_8c84e4:
	mov_s r0,0x0
L_8c84e6:
	bl.d L_8edfb0
L_8c84ea:
	mov_s r1,r0
L_8c84ec:
	mov_s r1,0x40
L_8c84ee:
	mov_s r0,0x800474
L_8c84f4:
	st_s r1,[r0]
	.global L_8c84f6
L_8c84f6:
	mov_s r2,0x100149c
L_8c84fc:
	ld r4,[r13, 0x34]
L_8c8500:
	mov_s r0,0x0
L_8c8502:
	mov_s r1,r0
L_8c8504:
	bl.d L_8edff8
L_8c8508:
	ld_s r3,[r13,0x30]
	.global L_8c850a
L_8c850a:
	.byte 0x35,0x06
