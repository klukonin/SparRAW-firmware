/* СГЕНЕРИРОВАНО tools/mkhook.py — хук на 0x008c2190, вытеснено 6 Б.
 * Поток: патч в 0x008c2190 -> __hook_008c2190 -> ext_on_tx_bcon() -> вытесненные
 * инструкции -> возврат в 0x008c2196. */
	.section .text.ext,"ax"
	.global __hook_008c2190
__hook_008c2190:
	/* сохранить аргументы и blink: наш обработчик их затрёт */
	st.a r0,[sp,-4]
	st.a r1,[sp,-4]
	st.a r2,[sp,-4]
	st.a r3,[sp,-4]
	st.a r4,[sp,-4]
	st.a r5,[sp,-4]
	st.a r6,[sp,-4]
	st.a r7,[sp,-4]
	st.a r12,[sp,-4]
	st.a blink,[sp,-4]
	bl ext_on_tx_bcon
	ld.ab blink,[sp,4]
	ld.ab r12,[sp,4]
	ld.ab r7,[sp,4]
	ld.ab r6,[sp,4]
	ld.ab r5,[sp,4]
	ld.ab r4,[sp,4]
	ld.ab r3,[sp,4]
	ld.ab r2,[sp,4]
	ld.ab r1,[sp,4]
	ld.ab r0,[sp,4]
	/* вытесненные инструкции оригинала */
	.byte 0xf1,0xc0	/* 8c2190:	c0f1                	push_s	blink */
	bl __hook_tgt_008c02c0	/* было: 8c2192:	0932 ff0f           	bl	-7888	;8c02c0 <__JLI_TABLE__+0x8c01c0> */
	b __hook_ret_008c2190
