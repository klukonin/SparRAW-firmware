/* obj__has_pending_1c_10 @ 0x8c3800, 44 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: sm_pring__notify_vring_state, vring__stop_hw
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global obj__has_pending_1c_10
obj__has_pending_1c_10:
	.global L_8c3800
L_8c3800:
	ld_s r1,[r0,0x1c]
L_8c3802:
	sub.f r1,r1,0x0
L_8c3806:
	mov.ne r1,0x1
L_8c380a:
	extb.f 0x0,r1
L_8c380e:
	mov_s r2,0x0
L_8c3810:
	bne_s L_8c3826
L_8c3812:
	ld_s r0,[r0,0x10]
L_8c3814:
	sub.f r0,r0,0x0
L_8c3818:
	mov.ne r0,0x1
L_8c381c:
	extb.f 0x0,r0
L_8c3820:
	mov.eq r0,r2
L_8c3824:
	beq_s L_8c3828
	.global L_8c3826
L_8c3826:
	mov_s r0,0x1
	.global L_8c3828
L_8c3828:
	j_s.d [blink]
L_8c382a:
	extb_s r0,r0
