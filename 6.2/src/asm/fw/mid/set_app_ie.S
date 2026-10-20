/* set_app_ie @ 0x8e6224, 128 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   set_app_ie: frame type %x length %d
 * Зовут его: mid__apply_app_ies
 * Зовёт сам: TX_API__free_memory, __ld_r17_to_r13_ret, __st_r17_to_r13, app_ie__print_ies, app_ies__clear, app_ies__set_buffer, fw_log_emit2, fw_sysassert_fatal
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global set_app_ie
set_app_ie:
	.global L_8e6224
L_8e6224:
	push_s blink
L_8e6226:
	bl L_8c01d8
L_8e622a:
	mov_s r16,r0
L_8e622c:
	mov_s r14,r1
L_8e622e:
	mov_s r13,r2
L_8e6230:
	mov_s r17,r3
L_8e6232:
	mov_s r1,0x100c8ac
L_8e6238:
	mov_s r0,0x2b
L_8e623a:
	mov_s r2,r14
L_8e623c:
	bl.d L_8dcc80
L_8e6240:
	mov_s r3,r13
L_8e6242:
	brhs r14,0x5,L_8e6294
L_8e6246:
	ldb.x r14,[0x8023b8,r14]
L_8e624e:
	add r0,pcl,0xa
L_8e6252:
	add1_s r0,r0,r14
L_8e6254:
	j_s [r0]
L_8e6256:
	add r16,r16,0x1e0
L_8e625a:
	b_s L_8e6272
L_8e625c:
	add r16,r16,0x1b0
L_8e6260:
	b_s L_8e6272
L_8e6262:
	add r16,r16,0x1bc
L_8e6266:
	b_s L_8e6272
L_8e6268:
	add r16,r16,0x1c8
L_8e626c:
	b_s L_8e6272
L_8e626e:
	add r16,r16,0x1d4
	.global L_8e6272
L_8e6272:
	bl.d L_8c6784
L_8e6276:
	mov_s r0,r16
L_8e6278:
	cmp_s r0,0x0
L_8e627a:
	bl.ne L_8cb10c
L_8e627e:
	breq_s r13,0,L_8e62a0
L_8e6280:
	mov_s r0,r16
L_8e6282:
	mov_s r1,r17
L_8e6284:
	mov_s r2,r13
L_8e6286:
	bl.d L_8e693c
L_8e628a:
	mov_s r3,0x0
L_8e628c:
	bl.d L_8e1008
L_8e6290:
	mov_s r0,r16
L_8e6292:
	b_s L_8e62a0
	.global L_8e6294
L_8e6294:
	mov_s r0,blink
L_8e6296:
	mov_s r1,0x11f4
L_8e629c:
	bl L_8c9b28
	.global L_8e62a0
L_8e62a0:
	b L_8c023c
