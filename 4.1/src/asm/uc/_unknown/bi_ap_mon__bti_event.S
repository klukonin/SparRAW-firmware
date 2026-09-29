/* bi_ap_mon__bti_event @ 0x931154, 80 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовёт сам: bi_manager__kind_switch
 */
	.section .text.bi_ap_mon__bti_event,"ax",@progbits
	.global bi_ap_mon__bti_event
bi_ap_mon__bti_event:
L_931154:
	st.a r13,[sp,-0xc]
L_931158:
	st blink,[sp, 0x4]
L_93115c:
	st_s r14,[sp,0x8]
L_93115e:
	mov_s r14,r1
L_931160:
	ldb_s r1,[r0]
L_931162:
	mov_s r13,r0
L_931164:
	bmsk_s r1,r1,0x3
L_931166:
	or r1,r1,0xcaf000
L_93116e:
	mov_s r32,r1
L_931170:
	st.ab r1,[r25,0x4]
L_931174:
	bclr r25,r25,0xa
L_931178:
	ldb_s r2,[r13]
L_93117a:
	mov_s r1,0x801e14
L_931180:
	ldw_s r0,[r1,0x4]
L_931182:
	stb_s r2,[r1,0x12]
L_931184:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_931186:
	stw_s r0,[r1,0x4]
L_931188:
	mov r0,0x801e94
L_931190:
	bl.d L_9289e4
L_931194:
	mov r1,r14
L_931198:
	ld blink,[sp, 0x4]
L_93119c:
	ld_s r14,[sp,0x8]
L_93119e:
	j_s.d [blink]
L_9311a0:
	ld.ab r13,[sp,0xc]
