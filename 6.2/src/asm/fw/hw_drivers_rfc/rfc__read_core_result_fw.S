/* rfc__read_core_result_fw @ 0x8d3628, 80 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: hwd_rfc_powerup_deep_all_rfs_fw, rfc__read_calib_block
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, hwd_rfc_write_core_fw
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global rfc__read_core_result_fw
rfc__read_core_result_fw:
	.global L_8d3628
L_8d3628:
	push_s blink
L_8d362a:
	bl.d L_8c01e0
L_8d362e:
	mov_s r4,r1
L_8d3630:
	mov_s r13,r2
L_8d3632:
	mov_s r0,0x0
L_8d3634:
	st_s r0,[r2]
L_8d3636:
	mov_s r2,0x889100
L_8d363c:
	ld_s r1,[r2,0x18]
L_8d363e:
	mov_s r14,0x889000
L_8d3644:
	bset_s r1,r1,0x6
L_8d3646:
	st_s r1,[r2,0x18]
L_8d3648:
	ld_s r1,[r2,0x18]
L_8d364a:
	mov_s r15,0xdeadbeef
L_8d3650:
	bclr_s r1,r1,0x6
L_8d3652:
	st_s r1,[r2,0x18]
L_8d3654:
	mov_s r1,0x4
L_8d3656:
	mov_s r2,r4
L_8d3658:
	bl.d L_8d415c
L_8d365c:
	mov_s r3,r0
L_8d365e:
	ld.as r0,[r14,0xfb]
L_8d3662:
	cmp_s r0,0x1
L_8d3664:
	mov.ne r0,r15
L_8d3668:
	bne_s L_8d3672
L_8d366a:
	ld r0,[r14, 0xd8]
L_8d366e:
	mov_s r1,0x1
L_8d3670:
	st_s r1,[r13]
	.global L_8d3672
L_8d3672:
	b L_8c024c
L_8d3676:
	nop_s
