/* dma_is_idle @ 0x8cdaf8, 72 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   dma_is_idle: sw_head:0x%x, sw_head4read:0x%x
 * Зовут его: sm_pring__all_wb_done_evt, sm_pring__eop_evt, sm_pring__timeout
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, fw_log__emit2
 */
	.section .text.dma_is_idle,"ax",@progbits
	.global dma_is_idle
dma_is_idle:
	.global L_8cdaf8
L_8cdaf8:
	push_s blink
L_8cdafa:
	bl L_8c02c4
L_8cdafe:
	mul64 r0,0x380
L_8cdb02:
	add r2,mlo,0x4409880
L_8cdb0a:
	lsr_s r2,r2,0x3
L_8cdb0c:
	bic r2,r2,0x3
L_8cdb10:
	ld_s r13,[r2]
L_8cdb12:
	add r0,mlo,0x44098c0
L_8cdb1a:
	lsr_s r0,r0,0x3
L_8cdb1c:
	bic r0,r0,0x3
L_8cdb20:
	ld_s r14,[r0]
L_8cdb22:
	breq_s r1,0,L_8cdb36
L_8cdb24:
	mov_s r2,0x1018540
L_8cdb2a:
	mov_s r0,0x0
L_8cdb2c:
	mov_s r1,0x2
L_8cdb2e:
	mov_s r3,r13
L_8cdb30:
	bl.d L_8edff8
L_8cdb34:
	mov_s r4,r14
	.global L_8cdb36
L_8cdb36:
	cmp_s r13,r14
L_8cdb38:
	mov_s r0,0x1
L_8cdb3a:
	b.d L_8c0334
L_8cdb3e:
	sub_s.ne r0,r0,r0
