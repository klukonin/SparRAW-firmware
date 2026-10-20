/* maintain_sm__config_mcs_en_vec @ 0x8c62a4, 92 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   maintain_sm::config_mcs_en_vec MCS_SHORT_VEC 4_8
 *   maintain_sm::config_mcs_en_vec mcs_is_restricted=%d
 * Зовут его: MAINTAIN_SM__FBF_DELAYED, maintain_sm__reset_link_cfg
 * Зовёт сам: __ld_r13_ret, fw_log__emit0, fw_log__emit1, regd__allow_if_not_jp_b
 * Глобалы (через gp): 0x8002d0
 */
	.section .text.maintain_sm__config_mcs_en_vec,"ax",@progbits
	.global maintain_sm__config_mcs_en_vec
maintain_sm__config_mcs_en_vec:
	.global L_8c62a4
L_8c62a4:
	push_s blink
L_8c62a6:
	bl.d L_8d749c
L_8c62aa:
	push_s r13
L_8c62ac:
	mov_s r13,r0
L_8c62ae:
	ld_s r0,[gp,0x160]
L_8c62b0:
	brne_s r0,0,L_8c62ce
L_8c62b2:
	cmp_s r13,0x0
L_8c62b4:
	mov r0,0x1de
L_8c62b8:
	mov.eq r0,0x1dde
L_8c62c0:
	mov_s r2,0x8013d0
L_8c62c6:
	stw_s r0,[r2,0x22]
L_8c62c8:
	lsr_s r0,r0,0x10
L_8c62ca:
	stw_s r0,[r2,0x24]
L_8c62cc:
	b_s L_8c62ec
	.global L_8c62ce
L_8c62ce:
	mov r2,0x1d0
L_8c62d2:
	mov_s r1,0x8013d0
L_8c62d8:
	stw_s r2,[r1,0x22]
L_8c62da:
	lsr_s r2,r2,0x10
L_8c62dc:
	stw_s r2,[r1,0x24]
L_8c62de:
	mov_s r2,0x1011ed4
L_8c62e4:
	mov_s r0,0x0
L_8c62e6:
	bl.d L_8edfb0
L_8c62ea:
	mov_s r1,0x2
	.global L_8c62ec
L_8c62ec:
	mov_s r2,0x1011f08
L_8c62f2:
	mov_s r0,0x0
L_8c62f4:
	mov_s r1,0x2
L_8c62f6:
	bl.d L_8edfcc
L_8c62fa:
	mov_s r3,r13
L_8c62fc:
	b L_8c033c
